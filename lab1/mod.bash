#!/bin/bash

if [[ $# -lt 10 ]]; then
  let i=1
  for p in $@; do
    echo "Parameter $i = $p"
	(( i++ ))
  done
else
  echo "Number of parameters is 10 or more"
fi