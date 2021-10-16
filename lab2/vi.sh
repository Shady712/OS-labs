#!/bin/bash

let max_memory=0
let max_pid=0

for pid in `ps -aux | awk '{print $2}' | tail -n +2 | head -n -5`; do
  memory=`cat /proc/$pid/status | grep -E "VmRSS:.+" | awk -F: 'print $2' | grep -o -E "[0-9]+"`
  if [[ $memory -gt $max_memory ]]; then
    max_memory=$memory
	max_pid=$pid
  fi
done
echo "PID: $max_pid"
echo "RSS: $max_memory"