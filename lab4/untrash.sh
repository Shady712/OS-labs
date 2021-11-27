#!/bin/bash

trashLog="$HOME/.trash.log"
trashFolder="$HOME/.trash"

declare -a resultFirst
declare -a resultSecond

if ! [ -d "$trashFolder" ]; then
  echo "No trash directory"
  exit
fi

if ! [ -f "$trashLog" ]; then
  echo "No trash.log file"
  exit
fi

echo -e "\nResults:\n"
let id=1

# NF - Number of Fields
while read line; do
  tmp=$(echo "$line" | awk -F "///" '{print $1}' | awk -F "/" '{print $NF}')
  tmp=$(echo "$tmp" | rev | cut -c 2- | rev)
  if [[ -n "$line" && "$tmp" = "$1" ]]; then
    resultFirst[id]=$(echo "$line" | awk -F "///" '{print $1}')
	resultSecond[id]=$(echo "$line" | awk -F "///" '{print $2}' | cut -c 2-)
	echo "$id. ${resultFirst[id]}"
	resultFirst[id]=$(dirname $(echo "${resultFirst[id]}") | head -1)
	(( id++ ))
  fi
done < $trashLog

id=$(($id - 1))
echo -e "\nSelect the file"

read num
if [[ $num -lt 1 || $num -gt id ]]; then
  echo "invalid number"
  exit
fi

if ! [ -d "${resultFirst[num]}" ]; then
  echo -e "\nThe directory of the file now is not reachable -> restoring into home directory"
  resultFirst[num]="$HOME"
fi

if [ -f "${resultFirst[num]}/$1" ]; then
  echo -e "\nFile with the same name already exists in provided directory. Please, provide new name for file"
  read newName
  resultFirst[num]="${resultFirst[num]}/$newName"
else
  resultFirst[num]="${resultFirst[num]}/$1"
fi

echo "${resultSecond[num]}"
ln "${resultSecond[num]}" "${resultFirst[num]}"
rm "${resultSecond[num]}"
echo "File successfully untrashed"
