#!/bin/bash

file="$PWD/$1"
trashLog="$HOME/.trash.log"
trashFolder="$HOME/.trash"
timestamp=$(date +%s)

if ! [ -f "file" ]; then
  echo "$file: No such file"
  exit 0
fi
if ! [ -d "$trashFolder" ]; then
  mkdir "trashFolder"
fi

echo "$file : $trashFolder/$timestamp-Deleted" >> "$trashLog"
ln "$file" "$trashFolder/$timestamp-Deleted"
rm "$file"