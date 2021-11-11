#!/bin/bash

mkfifo pipe
echo "Enter +, *, any number or QUIT"
cmd=""
while [[ $cmd != "QUIT" ]]; do
  read cmd
  case $cmd in
    "+"|"*"|[0-9]*)
	echo "$cmd" >> pipe
	;;
	"QUIT")
	echo "QUIT" >> pipe
	rm pipe
	exit 0
	;;
	*)
	echo "QUIT: invalid arguments" >> pipe
	rm pipe
	exit 1
	;;
  esac
done