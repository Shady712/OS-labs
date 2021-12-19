#!/bin/bash

let K=30
let N=1700000

for ((i=0;i<$K;i++)); do
  `./newmem.sh $N` &
  sleep 1
done
