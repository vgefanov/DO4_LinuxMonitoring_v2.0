#!/bin/bash

function delete {
  deleted_files=$(cat ~/LM02/03/deleted_files.txt 2>/dev/null)
  for i in $deleted_files
  do
    test -d $i 2>/dev/null && sudo rm -rf $i 2>/dev/null
    test -f $i 2>/dev/null && sudo rm -rf $i 2>/dev/null
  done
}
delete
