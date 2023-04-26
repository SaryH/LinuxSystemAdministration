#!/bin/bash
#Part 8: Network management
#1- Open port 443 , 80
#2- Make the changes permanent
#3- Block ssh connection for your colleague ip to the VM.

sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --add-rich-rule='rule family="ipv4" source address="192.168.1.111" service name="ssh" reject' --permanent

sudo firewall-cmd --reload
