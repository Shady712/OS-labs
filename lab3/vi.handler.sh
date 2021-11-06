#!/bin/bash

echo $$ > .pid

term()
{
  echo "Handler: Signal from Generator is 'TERM' -> Finish work"
  exit 0
}

add()
{
  operation="add"
}

multiply()
{
  operation="multiply"
}

operation="add"
let answer=1

trap 'term' SIGTERM
trap 'add' USR1
trap 'multiply' USR2

while true; do
  echo "Handler: current operation is $operation"
  case $operation in
    "add")
	let answer=$answer+2
	;;
	"multiply")
	let answer="answer"*2
	;;
  esac
  echo "Handler: current answer is $answer"
  sleep 3
done
