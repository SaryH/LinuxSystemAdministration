#!/bin/bash

# Get a list of all system usage files
file_list=$(ls /tmp/task2/disk_usage* /tmp/task2/memory_usage* /tmp/task2/cpu_utilization* 2>/dev/null)

used_sum=0
used_count=0
avail_sum=0
avail_count=0
memory_av=0
memory_used=0
memory_av_sum=0
memory_used_sum=0;
memory_count=0
cpu_sum=0
cpu_count=0

# Loop through each file
for file in $file_list; do
  if [[ $file == "/tmp/task2/disk_usage"* ]]; then
    used_value=$(awk -F': Used: ' '{
      if ($2 ~ /M/) {
        sum += $2
      } else if ($2 ~ /G/) {
        sum += $2 * 1024
      }
    } END {print sum}' "$file")
    used_sum=$(echo "$used_sum + $used_value" | bc)
    ((used_count++))
    avail_value=$(awk -F', Available: ' '{
      if ($2 ~ /M/) {
        sum += $2
      } else if ($2 ~ /G/) {
        sum += $2 * 1024
      }
    } END {print sum}' "$file")
    avail_sum=$(echo "$avail_sum + $avail_value" | bc)
    ((avail_count++))
  elif [[ $file == "/tmp/task2/memory"* ]]; then
    memory_av=$(awk -F': Used: |, Available: ' '{sum += $2} END {print sum}' "$file")
    memory_av_sum=$(echo "$memory_av_sum + $memory_av" | bc)
    memory_used=$(awk -F '[: ,]+' '/Used/{if ($2 ~ /M/) {sub(/M/,"", $2); print $2/1024} else if ($2 ~ /G/) {sub(/G/,"", $2); print $2}}' "$file")
    memory_used_sum=$(echo "$memory_used_sum + $memory_used" | bc)
    ((memory_count++))
  elif [[ $file == "/tmp/task2/cpu_utilization"* ]]; then
    cpu_value=$(awk -F': ' '{sum += $2} END {print sum}' "$file")
    cpu_sum=$(echo "$cpu_sum + $cpu_value" | bc)
    ((cpu_count++))
  fi
done

# Calculate the average values
used_avg=$(echo "scale=2; $used_sum / $used_count" | bc)
avail_avg=$(echo "scale=2; $avail_sum / $avail_count" | bc)
memory_used_avg=$(echo "scale=2; $memory_used_sum / $memory_count" | bc)
memory_av_avg=$(echo "scale=2; $memory_av_sum / $memory_count" | bc)
cpu_avg=$(echo "scale=2; $cpu_sum / $cpu_count" | bc)

# Display the average values
echo "Average Used Disk Space: $used_avg MB"
echo "Average Free Disk Space: $avail_avg MB"
echo "Average Memory Usage: $memory_used_avg GB"
echo "Average Memory Free: $memory_av_avg GB"
echo "Average CPU Utilization: $cpu_avg%"
