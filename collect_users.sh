#!/bin/bash
users=$(who | cut -d ' ' -f1 | uniq | sort | tr '\n' ' ')
timestamp=$(date)
echo "$timestamp - $users" >> /var/log/logged_in_users.log
