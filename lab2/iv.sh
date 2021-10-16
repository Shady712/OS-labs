#!/bin/bash

file=proc.txt
echo "" > $file

for pid in `ps -aux | awk '{print $2}' | tail -n +2 | head -n -5`; do
  ppid=`cat /proc/$pid/status | grep -E "PPid:.+" | awk '{print $2}'`
  dir=/proc/$pid/sched
  exec_runtime=`cat $dir | grep -E "se\.sum_exec_runtime.+" | awk -F: '{print $2}'`
  nr_switches=`cat $dir | grep -E "nr_switches.+" | awk -F: '{print $2}'`
  art=`bc -l <<< "scale=6; $exec_runtime / $nr_switches"`
  echo "$pid $ppid $art" >> $file
done
cat $file | sort -n -k 2 > $file

cat $file | awk '{print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3}' > $file