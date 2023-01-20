#!/bin/bash

start_script=$(date +%s)
length_folder_name=$[ $(echo $1 | wc -m) - 1 ]
length_file_name=$[ $(echo $(echo $2 | awk -F. '{print $1}') | wc -m) - 1 ]
length_file_extension=$[ $(echo $(echo $2 | awk -F. '{print $2}') | wc -m) - 1 ]
free_space=$(df / | head -2 | tail +2 | awk '{printf("%d", $4)}')
declare -x start_time=$(date +%F" "%H:%M:%S)
declare -x letters_folder_names=$1
declare -x file_name=$(echo $2 | awk -F. '{print $1}')
declare -x file_extension=$(echo $2 | awk -F. '{print $2}')
declare -x file_size=$[ $(echo $3 | tr -d [:alpha:]) ]

if [ $# -ne 3 ]; then
    echo "Error. Need to enter 3 parameter, you have entered $# parameters!"
elif [[ $length_folder_name -gt 7 ]]; then
    echo "Parameter 1. Must not exceed 7 characters. Change parameter 1"
elif [[ $letters_folder_names =~ [^A-Za-z] ]]; then
    echo "Parameter 1. A list of English alphabet letters. Change parameter 1"
elif [[ $length_file_name -gt 7 ]] || [[ $length_file_extension -gt 3 ]] || [[ $length_file_name -lt 1 ]] || [[ $length_file_extension -lt 1 ]]; then
    echo "Parameter 2. The name should not exceed 7 characters, the extension should not exceed 3 characters. Example abc.abc. Change parameter 2"
elif [[ $2 =~ [^A-Za-z.] ]]; then
    echo "Parameter 2. A list of English alphabet letters. Change parameter 2"
elif [[ !($3 =~ [Mm]b$) ]]; then
    echo "Parameter 3. File size in megabytes, specify mb or Mb. Change parameter 3"
elif [[ $file_size -gt 100 ]] || [[ $file_size -le 0 ]]; then
    echo "Parameter 3. File size from 1 to 100 megabytes. Change parameter 3"
elif [[ $free_space -ge $((1000000 + $(($file_size * 1000)))) ]]; then
    bash ~/LM02/02/create.sh
    end_script=$(date +%s)
    end_time=$(date +%F" "%H:%M:%S)
    echo "Script finish $end_time" | tee -a ~/LM02/02/logs_file.txt
    result_time=$(($end_script-$start_script))
    if [[ $result_time -lt 60 ]]; then
        minuts=0
        seconds=$result_time
    else
        minuts=$(($result_time/60))
        seconds=$(($result_time%60))
    fi
    echo "Total running time of the script $minuts minut $seconds sec" | tee -a ~/LM02/02/logs_file.txt
else
    echo "Not enough free space"
fi

# bash main.sh azsx abcd.efg 100mb
# sudo find ~ -type f -name "*.efg" -delete
# df -h /
