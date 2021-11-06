#!/bin/bash

mkdir "test" && {
  echo "catalog test was created successfully" > report
  touch ./"test"/$(date +"%F_%R")
}

ping -c 1 "www.net_nikogo.ru" 2 > pipe.txt {
  echo "$(date +"%F_%R") www.net_nikogo.ru is unavailable" >> report
  cat pipe.txt >> report
  rm pipe.txt
}