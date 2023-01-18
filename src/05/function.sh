#!/bin/bash

file="../04/1.log ../04/2.log ../04/3.log ../04/4.log ../04/5.log"

function code_sort {
  local count=$(cat $file | wc -l)
  for((i=1;i<=$count;i++))
  do
    echo $(cat $file | sort -k9 | head -$i | tail +$i)
  done
}

function ip_sort {
  local count=$(cat $1 | awk -F- '{print $1}' | sort -u | wc -l)
  for((i=1;i<=$count;i++))
  do
    echo $(cat $1 | awk -F- '{print $1}' | sort -u | head -$i | tail +$i)
  done
}

function error_code_find {
  local count=$(cat $file | wc -l)
  for((i=1;i<=$count;i++))
  do
    local code=$(cat $file | awk '{print $9}' | head -$i | tail +$i)
    if [[ $code -ge 400 ]]; then
      echo $(cat $file | head -$i | tail +$i)
    fi
  done
}
