#!/bin/bash

curDate=$(date +%F)
curDateSec=$(date +%s)
backupPath="$HOME/Backup-$curDate"
sourcePath="$HOME/source"
backupLog="$HOME/.backup-report.log"
hasBackup=""

for line in $(echo $(ls $HOME | grep "Backup-")); do
  date=$(echo $line | awk -F "Backup-" '{print $2}')
  dateSec=$(date -j -f '%Y-%m-%d' $date +%s)
  d=$(( $curDateSec - $dateSec ))
  # 604800 sec is 7 days
  if [[ 604800 -ge $d ]]; then
    backupPath="$HOME/Backup-$date"
	hasBackup="true"
	break
  fi
done

if [ $hasBackup ]; then
  for file in $sourcePath/*; do
    f="$backupPath/$(basename $file)"
    echo $f
	if [[ -f "$f" ]]; then
	  size1=$(stat -f %z "$file")
	  size2=$(stat -f %z "$f")
	  if [[ $size1 -ne $size2 ]]; then
	    mv "$f" $f.$curDate
		cp "$file" "backupPath"
		echo "$file was copied" >> $backupLog
		echo "$f renamed to $f.$curDate" >> $backupLog
	  fi
	else
	  cp "$file" "$backupPath"
	  echo "$file was copied" >> $backupLog
	fi
  done
else
  mkdir "$HOME/Backup-$curDate"
  echo "$HOME has no backup folder"
  echo "Backup-$curDate was created"
  echo "Backup-$curDate was created" >> $backupLog
  for file in $sourcePath/*; do
    cp "$file" "$backupPath"
	echo "$file was copied" >> $backupLog
  done
fi
