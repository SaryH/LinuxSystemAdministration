#!/bin/bash
#Part 5: permissions
#SELinux must be running in the Enforcing mode (permanent even after reboot).

sed -i 's/SELINUX=permissive/SELINUX=enforcing/g' /etc/sysconfig/selinux
setenforce 1
