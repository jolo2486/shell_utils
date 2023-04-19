#!/bin/bash

# check if three arguments where given and outputs a help message otherwise
# $0 is a special variable for the scriptname.
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <filename> <running> <done> <interval>"
  exit 1
fi

# $1,2,3 corresponds to the first, second and third positional arguments
# respectively.
filename=$1
running=$2
done=$3
interval=$4

# continuously check the file <filename> for done and exit if found.
while true
do
  if grep -q -i "$done" "$filename"; then
    break
  else
    count=$(grep -o -i "$running" "$filename" | wc -l)
    echo -ne "\r$running : $count      ..."
    sleep $interval # wait 5 sec, then check again.
  fi
done

echo "'$done' appeared in $filename. Considering it done!"
