#!/bin/bash

let i=10
while [ $i -lt 15 ]; do
  touch "$i" | at "00:$i"
  (( i++ ))
done
