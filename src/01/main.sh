#!/bin/bash

length_folder_name=$[ $(echo $3 | wc -m) - 1 ]
length_file_name=$[ $(echo $(echo $5 | awk -F. '{print $1}') | wc -m) - 1 ]
length_file_extension=$[ $(echo $(echo $5 | awk -F. '{print $2}') | wc -m) - 1 ]

declare -x absolute_path=$1
declare -x number_of_subfolders=$2
declare -x letters_folder_names=$3
declare -x number_of_files=$4
declare -x file_name=$(echo $5 | awk -F. '{print $1}')
declare -x file_extension=$(echo $5 | awk -F. '{print $2}')
declare -x file_size=$[ $(echo $6 | tr -d [:alpha:]) ]

if [ $# -ne 6 ]; then
    echo "Error. Need to enter 6 parameter, you have entered $# parameters!"
    elif [[ !(-d $absolute_path) ]]; then
        echo "Wrong way young padawan. Change parameter 1"
    elif [[ $number_of_subfolders =~ [^0-9] ]]; then
        echo "Parameter 2. The number of subfolders. Change parameter 2"
    elif [[ $length_folder_name -gt 7 ]]; then
        echo "Parameter 3. Must not exceed 7 characters. Change parameter 3"
    elif [[ $letters_folder_names =~ [^A-Za-z] ]]; then
        echo "Parameter 3. A list of English alphabet letters. Change parameter 3"
    elif [[ $number_of_files =~ [^0-9] ]]; then
        echo "Parameter 4. Is the number of files in each created folder. Change parameter 4"
    elif [[ $length_file_name -gt 7 ]] || [[ $length_file_extension -gt 3 ]] || [[ $length_file_name -lt 1 ]] || [[ $length_file_extension -lt 1 ]]; then
        echo "Parameter 5. The name should not exceed 7 characters, the extension should not exceed 3 characters. Example abc.abc. Change parameter 5"
    elif [[ $5 =~ [^A-Za-z.] ]]; then
        echo "Parameter 5. A list of English alphabet letters. Change parameter 5"
    elif [[ !($6 =~ [Kk]b$) ]]; then
        echo "Parameter 6. File size in kilobytes, specify kb or Kb. Change parameter 6"
    elif [[ $file_size -gt 100 ]] || [[ $file_size -le 0 ]]; then
        echo "Parameter 6. File size from 1 to 100 kilobytes. Change parameter 6"
    else
        bash ~/LM02/01/create.sh
fi

# bash main.sh ~/LM02/01 3 azsx 3 abcd.efg 5kb
# rm -r a*
