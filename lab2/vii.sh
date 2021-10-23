#!/bin/bash

let id=0
for pid in `ps -aux | awk '{print $2}' | tail -n +2 | head -n +5`; do
  cmdline=`cat "/proc/$pid/cmdline"`
  bytes=`cat "/proc/$pid/io" | grep -E "read_bytes:.+" | awk '{print $2}'`
  processes[$id]="$pid:$cmdline:$bytes"
  (( id++ ))
done
sleep 1m

let id=0
for process in ${processes[@]}; do
  pid=`echo $process | awk -F ":" '{print $1}'`
  cmdline=`echo $process | awk -F ":" '{print $2}'`
  bytes=`echo $process | awk -F ":" '{print $3}'`
  cur_bytes=`cat "/proc/$pid/io" | grep -E "read_bytes:.+" | awk '{print $2}'`
  let bytes_per_min=$cur_bytes-$bytes
  processes[$id]="$pid:$cmdline:$bytes_per_min"
  (( id++ ))
done

echo "${processes[*]}" | sort -k 3 | tail -n 3 | awk '{print $1"\n"$2"\n"$3}'