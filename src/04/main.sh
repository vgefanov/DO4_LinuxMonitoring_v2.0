#!/bin/bash
source ~/LM02/04/function.sh

if [ $# -ne 0 ]; then
  echo "Error. Parameters not needed"
  else
  start_time=$(date +%F" "%H:%M:%S)
  echo "Script start $start_time"
  for i in {1..5}
  do
    echo -n "" > ~/LM02/04/tmp$i.log
    number_of_records=$((100 + $RANDOM % 901))
    echo " Запоняю $i лог $number_of_records записями"
    for((j=0; j<$number_of_records; j++))
    do
      date=[$(expr $(date +%_d) - $i)/$(date | awk '{print $3"/"$4}'):$(get_time)" "$(date +%z)]
      echo $(get_ip) - - $date \"$(get_method) $(get_url) HTTP/1.1\" $(get_code) $((100 + $RANDOM % 100000)) \"https:/$(get_url)\" \"$(get_agent)\" >> ~/LM02/04/tmp$i.log
    done
  done
  for i in {1..5}
  do
    echo -n "" > ~/LM02/04/$i.log
    cat ~/LM02/04/tmp$i.log | sort -k4 >> ~/LM02/04/$i.log
    rm ~/LM02/04/tmp$i.log
  done
  end_time=$(date +%F" "%H:%M:%S)
  echo "Script finish $end_time"
fi

# rm *.log
