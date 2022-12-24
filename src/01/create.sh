#!/bin/bash

function name_generator {
    local length=`expr length $1`
    for (( i=1; i<=$length; i++ ))
    do
        local arr[$i]=`expr substr $1 $i 1`
        local name+="${arr[$i]}"
    done
    echo $name
}

function add_sign {
    local name=$1
    local symbol=$3
    local length=`expr length $2`
    for (( i=1; i<=$length; i++ ))
    do
        local arr[$i]=`expr substr $2 $i 1`
    done
    local index=`expr index $name ${arr[$symbol]}`
    local tmp_name=$(expr substr $name 1 $index)${arr[$symbol]}$(echo ${name:$index})
    local name=$tmp_name
    echo $name
}

touch logs_file.txt
echo -n "" > logs_file.txt
for (( j=0; j<$number_of_subfolders; j++ ))
do
    cd $absolute_path
    free_space=$(df / |  head -2 | tail +2 | awk '{printf("%d", $4)}')
    if [[ $free_space -le 1048576 ]]
        then
            break
    fi
    
    # create folder
    name_dir=$(name_generator $letters_folder_names)
    date=$(date +%D | awk -F / '{print $2$1$3}')
    tmp_name_dir=$name_dir"_"$date
    char=0
    while [ -e "$tmp_name_dir" ] || [[ `expr length $name_dir` -lt 4 ]];
    do
        if [[ char -ge `expr length $letters_folder_names` ]] || [[ `expr length $letters_folder_names` -eq 1 ]]
        then
            char=1
        else
            char=$(($char+1))
        fi
        name_dir=$(add_sign $name_dir $letters_folder_names $char)
        tmp_name_dir=$name_dir"_$date"
    done
    mkdir $tmp_name_dir
    echo $(pwd)"/$tmp_name_dir/" `date +%Y-%m-%d-%H-%M` >> logs_file.txt

    # create files
    for ((f=0; f < $number_of_files; f++))
    do
        char_file=0
        name_file=$(name_generator $file_name)
        file=$tmp_name_dir"/$name_file"_"$date.$file_extension"
        while [ -e $file ] || [[ `expr length $name_file` -lt 4 ]];
        do
            if [[ char_file -ge `expr length $letters_folder_names` ]] || [[ `expr length $file_name` -eq 1 ]]
            then
                char_file=1
            else
                char_file=$(($char_file+1))
            fi
            name_file=$(add_sign $name_file $file_name $char_file)
            file=$tmp_name_dir"/$name_file"_"$date.$file_extension"
        done
        touch $file
         fallocate -l $file_size"KB" $file
        echo $(pwd)"/$file" `date +%Y-%m-%d-%H-%M` `ls -lh $file | awk '{print $5}'` >>  logs_file.txt
        free_space=$(df / |  head -2 | tail +2 | awk '{printf("%d", $4)}')
        if [[ $free_space -le 1048576 ]]
        then
            exit 1
        fi
    done
done
