#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error. Need to enter 1 parameter, you have entered $# parameters!"
  exit 1
fi
if [[ $1 = [^1-3] ]]; then
  echo "Error. Parameter - a number from 1 to 3, where
  1 - cleaning the system according to the log file;
  2 - cleaning the system by date and time of creation;
  3 - clearing the system by name mask (i.e. symbols, underscore and date)."
  elif [ $1 -eq 1 ] && [ $# -eq 1 ]; then
  if ! [ -e ~/LM02/02/logs_file.txt ]; then
    echo "~/LM02/02/logs_file.txt: No such file"
    exit 1
    else
    deleted_files=$(cat ~/LM02/02/logs_file.txt | awk '{print $1}' | tail -n +2 | head --lines=-2)
    for i in $deleted_files
    do
      echo $i >> ~/LM02/03/deleted_files.txt
    done
    bash ~/LM02/03/deleted.sh
    rm ~/LM02/03/deleted_files.txt 2>/dev/null
  fi

  elif [ $1 -eq 2 ] && ([ $# -eq 1 ] || [ $# -eq 5 ]); then
  if [ $# -eq 1 ]; then
    echo "Еnter the start time to the nearest minute in the format 'yyyy-mm-dd hh:mm'"
    read start_time
    elif [ $# -eq 5 ]; then
    start_time="$2 $3"
  fi
  date_time="^[12][0-9]{3}(-)(0[1-9]|1[0-2])(-)(0[1-9]|[12][0-9]|3[01])[\ ](0[0-9]|1[0-9]|2[0-4])(:)[0-5][0-9]$"
  if [[ ! "$start_time" =~ $date_time ]]; then
    echo "incorrect entry of start date"
    exit 1
  fi
  if [ $# -eq 1 ]; then
    echo "Enter the end time to the nearest minute in the format 'yyyy-mm-dd hh:mm'. After that, all files created in Part 2 in the specified time period will be deleted."
    read end_time
    elif [ $# -eq 5 ]; then
    end_time="$4 $5"
  fi
  if [[ ! "$end_time" =~ $date_time ]]; then
    echo "incorrect entry of end date"
    exit 1
  fi
  if [[ $(date -d "$end_time" +%s) -le $(date -d "$start_time" +%s) ]]; then
    echo "Error. The end time is earlier than the start time. Please try again"
    exit 1
  fi
  time_period_files=$(sudo find / -newermt "$start_time" ! -newermt "$end_time" 2>/dev/null)
  compare_files=$(cat ~/LM02/02/logs_file.txt | awk '{print $1}' | tail -n +2 | head --lines=-2)
  for i in $compare_files
  do
    echo $i >> ~/LM02/03/tmp_logs.txt
  done
  count=$(echo "$time_period_files" | grep -f ~/LM02/03/tmp_logs.txt | wc -l)
  for((j=1; j<=$count; j++))
  do
    echo $(echo "$time_period_files" | grep -f ~/LM02/03/tmp_logs.txt | head -$j | tail +$j) >> ~/LM02/03/deleted_files.txt
  done
  bash ~/LM02/03/deleted.sh
  rm ~/LM02/03/deleted_files.txt ~/LM02/03/tmp_logs.txt 2>/dev/null

  elif [ $1 -eq 3 ] && [ $# -eq 1 ]; then
    echo "Enter the name mask in the format 'abcd_ddmmyy'"
    read name_mask
    mask=$(echo $name_mask | awk -F_ '{print $1}')
    date=$(echo $name_mask | awk -F_ '{print $2}')
    length_name=$(expr length $mask)
    name="([^\s]*\/)"
    for((i=1; i<=$length_name; i++))
    do
      arr[$i]=$(expr substr $mask $i 1) 2>/dev/null
      name+="${arr[$i]}+"
    done
    name+="_$date/"
    i=1
    count=$(sudo find / -type d 2>/dev/null | egrep "*$name*" | wc -l)
    for((i=1; i<=$count; i++))
    do
      echo $(sudo find / -type d 2>/dev/null | egrep "*$name*" | head -$i | tail +$i) >> ~/LM02/03/deleted_files.txt
    done
    bash ~/LM02/03/deleted.sh
    rm ~/LM02/03/deleted_files.txt 2>/dev/null
  else
    echo "incorrect number of parameters or invalid parameter"
fi
