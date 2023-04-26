#!/bin/bash
#Part 4: permissions
#Copy /etc/fstab to /var/tmp name admin, the user1 could read, write and modify it, while user2 can’t do any permission.

cp /etc/fstab /var/tmp/admin
chown user1:user1 /var/tmp/admin
chmod 600 /var/tmp/admin

