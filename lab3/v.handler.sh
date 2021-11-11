#!/bin/bash

ppid=$$
operation="+"
let answer=1

(tail -f pipe) |
while true; do
  read line
  case $line in
    "QUIT")
	pkill -P $ppid
	exit 0
	;;
	"+"|"*")
	operation=$line
	;;
	*)
	case $operation in
	  "+")
	  answer=$(($answer+$line))
	  ;;
	  "*")
	  answer=$(($answer * $line))
	  ;;
	esac
	echo $answer
	;;
  esac
done