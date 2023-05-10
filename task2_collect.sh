#!/bin/bash

# Get current timestamp
timestamp=$(date +%Y-%m-%d-%H%M%S)

# Collect disk usage and get used and available space for each main partition
disk_usage=$(df -h --output=target,used,avail | awk 'NR>1{print $1 ": Used: " $2 ", Available: " $3}')
echo "$disk_usage" > "/tmp/task2/disk_usage_${timestamp}.txt"

# Collect memory usage and get used and available memory
memory_usage=$(free -h | awk 'NR==2{print "Used: " $3 ", Available: " $7}')
echo "$memory_usage" > "/tmp/task2/memory_usage_${timestamp}.txt"

# Collect CPU utilization and get the total percentage usage
cpu_usage=$(top -bn1 | awk 'NR==3{printf "%.2f%%", $2}')
echo "CPU Utilization: $cpu_usage" > "/tmp/task2/cpu_utilization_${timestamp}.txt"
