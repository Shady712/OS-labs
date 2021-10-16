#!/bin/bash

function time_to_sec {
  sec=${1:6}
  min=${1:3:2}
  hour=${1:0:2}
  echo $(echo "$sec+$min*60+$hour*3600" | bc)
}

str_start=$(date '+%H:%M:%S.%N')
start=$(time_to_sec $str_start)
today=$(date '+%Y-%m-%d')

for pid in `ps -aux | awk '{print $2}' | tail -n +2 | head -n -5`; do
  str_time=$(stat "/proc/"$pid | grep -E -s -h "Modify" | grep -E -s -h $today | awk '{print $3}')
  if [[ $str_time == "" ]]; then
    continue
  fi
  
  sec_time=$(time_to_sec $str_time)
  cmp=$(echo $start-$sec_time | bc)
  
  if [[ $(bc -l <<< "$cmp>1") -ne 1 ]]; then
    bytes=$(grep -E -s -h "read_bytes" "/proc/$pid/io" | grep -E -s -o "[0-9]+")
	echo $pid $bytes
  fi
done | sort -n -k 2 | tail -n 3 | awk '{print $1":"$2}'