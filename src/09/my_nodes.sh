#!/bin/bash

cpu=$(top -b | head -3 | tail +3 | awk '{print $2}')
mem_free=$(top -b | head -4 | tail +4 | awk '{print $6}')
mem_used=$(top -b | head -4 | tail +4 | awk '{print $8}')
mem_cache=$(top -b | head -4 | tail +4 | awk '{print $10}')
disk_used=$(df / | tail -n1 | awk '{print $3}')
disk_available=$(df / | tail -n1 | awk '{print $4}')

echo "<br>CPU_USAGE <b>$cpu</b></br>"
echo "<br>MEMORY_FREE <b>$mem_free</b></br>"
echo "<br>MEMORY_USED <b>$mem_used</b></br>"
echo "<br>MEMORY_CACHE <b>$mem_cache</b></br>"
echo "<br>DISK_USED <b>$disk_used</b></br>"
echo "<br>DISK_AVAILABLE <b>$disk_available</b></br>"
echo "<br><img src="vovka.jpeg"></br>"
