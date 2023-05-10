#!/bin/bash

mkdir /tmp/task2

./createIndex.sh

mv index.html /var/www/html/index.html

systemctl start httpd
systemctl enable httpd

echo "0 * * * * /root/LinuxSystemAdministration/LinuxSystemAdministration/task2.sh" | crontab -
