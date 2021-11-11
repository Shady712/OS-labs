#!/bin/bash

./iv.proc.sh &
pid1=$!
./iv.proc.sh &
pid2=$!
./iv.proc.sh &
pid3=$!

renice -n 10 -p $pid1
kill $pid3