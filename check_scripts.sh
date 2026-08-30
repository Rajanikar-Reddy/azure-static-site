#!/bin/bash
for file in *.sh
do
  if [ -x "$file" ]
  then
    echo "$file is executable"
  else
    echo "$file is NOT executable"
  fi
done
