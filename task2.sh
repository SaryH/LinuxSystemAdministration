#!/bin/bash

./task2_collect.sh
./task2_average.sh > /tmp/task2/data.txt

web_directory="/var/www/html"

#Generate CPU usage webpage
cpu_webpage="$web_directory/cpu.html"
echo "<h1>CPU Usage</h1>" > "$cpu_webpage"
echo "<h2>Average:</h2>" >> "$cpu_webpage"
echo "$(cat /tmp/task2/data.txt | grep 'Average CPU Utilization')" >> "$cpu_webpage"
echo "<h2>Data:</h2>" >> "$cpu_webpage"
echo "<ul>" >> "$cpu_webpage"
for file in $(ls /tmp/task2/cpu_utilization_* 2>/dev/null); do
  timestamp=$(echo "$file" | awk -F'_' '{print $NF}' | awk -F'.' '{print $1}')
  data=$(cat "$file")
  echo "<li>Timestamp: $timestamp<br>$data</li>" >> "$cpu_webpage"
done
echo "</ul>" >> "$cpu_webpage"

#Memory page creation
memory_webpage="$web_directory/memory.html"
echo "<h1>Memory Usage</h1>" > "$memory_webpage"
echo "<h2>Average:</h2>" >> "$memory_webpage"
echo "$(cat /tmp/task2/data.txt | grep 'Average Memory Usage')" >> "$memory_webpage"
echo "<h2>Data:</h2>" >> "$memory_webpage"
echo "<ul>" >> "$memory_webpage"
for file in $(ls /tmp/task2/memory_usage* 2>/dev/null); do
  timestamp=$(echo "$file" | awk -F'_' '{print $NF}' | awk -F'.' '{print $1}')
  data=$(cat "$file")
  echo "<li>Timestamp: $timestamp<br>$data</li>" >> "$memory_webpage"
done
echo "</ul>" >> "$memory_webpage"

#Disk page creation
disk_webpage="$web_directory/disk.html"
echo "<h1>Disk Usage</h1>" > "$disk_webpage"
echo "<h2>Average:</h2>" >> "$disk_webpage"
echo "$(cat /tmp/task2/data.txt | grep 'Average Used Disk Space\|Average Free Disk Space')" >> "$disk_webpage"
echo "<h2>Data:</h2>" >> "$disk_webpage"
echo "<ul>" >> "$disk_webpage"
for file in $(ls /tmp/task2/disk_usage* 2>/dev/null); do
  timestamp=$(echo "$file" | awk -F'_' '{print $NF}' | awk -F'.' '{print $1}')
  data=$(cat "$file")
  echo "<li>Timestamp: $timestamp<br>$data</li>" >> "$disk_webpage"
done
echo "</ul>" >> "$disk_webpage"

