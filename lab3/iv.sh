#!/bin/bash

./iv.proc.sh &
pid1=$!
./iv.proc.sh &
pid2=$!
./iv.proc.sh &
pid3=$!

cpulimit --pid=$pid1 --limit=10 &

sleep 10 && kill $pid3 &