#!/bin/bash
#Part 7: Yum Repo
#1- Install tmux on your machine
#2- Install apache server on your machine(httpd) and Install mysql.
#3- Create a local yum repository on your local machine(available publicly) with the zabbix rpms:
#https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/
#4- Disable all other repositories and keep only the new repo
#5- Install zabbix rpms from the new repo (Download zabbix, zabbix-web,php, zabbix-server,zabbix-agent rpm’s and their dependencies)

sudo yum install tmux -y
sudo yum install httpd -y
sudo yum install mysql -y
