#!/bin/bash

output='report1.log'
arr=()
let i=0
> $output

while true; do
  arr+=(1 2 3 4 5 6 7 8 9 10)
  if [ $(($i % 100000)) == 0 ]; then
    echo $i >> $output
  fi
  i=$(($i + 1))
done
