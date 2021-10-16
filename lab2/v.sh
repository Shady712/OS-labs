#!/bin/bash

input="proc.txt"
output="extended_proc.txt"
let prev_ppid=-1
let sum=0
let count=0

while read line; do
  ppid=$(echo $line | cut -d ":" -f 2 | grep -E -s -o "[0-9]+")
  run_avg=$(echo $line | cut -d ":" -f 3 | -grep -E -s -o "[0-9]+")
  
  if (( prev_ppid != -1 && ppid != prev_ppid )); then
    arc=`bc -l <<< "scale=2; $sum / $count"`
	echo Average_Running_Children_of_ParentID=$prev_ppid is $arc
	sum=0
	count=0
  fi
  echo $line
  sum=`bc -l <<< "scale=2; $sum + $run_avg"`
  prev_ppid=ppid
  (( count++ ))
done < $input > $output

arc=`bc -l <<< "scale=2; $sum / $count"`
echo Average_Running_Children_of_ParentID=$prev_ppid is $arc >> $output