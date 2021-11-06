#!/bin/bash

echo MENU:
echo "1) + 2) * 3) TERM"
command=""

while [[ $command != "TERM" ]]; do
  read command
  case $command in
    "+")
	echo "Generator: Token = $command -> Passing signal = 'USR1' to the handler"
	kill -USR1 $(cat .pid)
	;;
	"*")
	echo "Generator: Token = $command -> Passing signal = 'USR2' to the handler"
	kill -USR2 $(cat .pid)
	;;
	"TERM")
	echo "Generator: Token = $command -> Finish work && Passing signal = 'SIGTERM' to the handler"
	kill -SIGTERM $(cat .pid)
	exit 0
	;;
	*)
	continue
	;;
  esac
done
