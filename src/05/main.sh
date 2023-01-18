#!/bin/bash
source ~/LM02/05/function.sh

if [ $# -ne 1 ]; then
  echo "Error. Need to enter 1 parameter, you have entered $# parameters!"
  exit 1
fi
if [[ $1 = [^1-4] ]]; then
  echo "Error. Parameter - a number from 1 to 4, where
  1 - All entries sorted by response code;
  2 - All unique IPs found in the entries;
  3 - All requests with errors (response code - 4xx or 5xx)
  4 - All unique IPs found among the erroneous requests"
fi
case $1 in
1)  code_sort | tee sort_by_code.txt;;
2)  ip_sort "$file" | tee sort_by_uniq_ip.txt;;
3)  error_code_find | tee sort_by_error_code.txt;;
4)  error_code_find > sort_by_error_code.txt
    ip_sort sort_by_error_code.txt | tee sort_by_uniq_ip_error_code.txt;;
*) echo incorrect number of parameters or invalid parameter
esac

#bash main.sh 1 && bash main.sh 2 && bash main.sh 3 && bash main.sh 4
# rm *.txt
