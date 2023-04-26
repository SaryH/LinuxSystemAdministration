#!/bin/bash
#Part 9: Cronjob
#Create a cronjob that will run at 1:30 AM every day and collect the users logged in and save them in a file. Format : timestamp – users. Note: the cronjob can run a script.

echo "30 1 * * * /root/LinuxSystemAdministration/collect_users.sh" | crontab -
