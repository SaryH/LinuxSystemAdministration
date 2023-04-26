#!/bin/bash
#Part 6
#Write a shell script that will keep running for 10 mins in the background and check the process that it's created and try to kill using commands.

start=$(date +%s)
while [ $(( $(date +%s) - $start )) -le 600 ]
do
sleep 1
done

echo "10mins finished"
