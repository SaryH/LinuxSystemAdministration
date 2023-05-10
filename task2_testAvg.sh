#!/bin/bash

# Get a list of all system usage files
file_list=$(ls disk_usage_* memory_usage_* cpu_utilization_* 2>/dev/null)

used_sum=0
used_count=0
avail_sum=0
avail_count=0
memory_av=0
memory_used=0
memory_av_sum=0
memory_used_sum=0
cpu_sum=0
cpu_count=0

# Loop through each file
for file in $file_list; do
  if [[ $file == disk_usage_* ]]; then
    used_value=$(awk -F': Used: ' '{
      if ($2 ~ /M/) {
        sum += $2
      } else if ($2 ~ /G/) {
        sum += $2 * 1024
      }
    } END {print sum}' "$file")
    used_sum=$((used_sum + used_value))
    ((used_count++))
    avail_value=$(awk -F', Available: ' '{
      if ($2 ~ /M/) {
        sum += $2
      } else if ($2 ~ /G/) {
        sum += $2 * 1024
      }
    } END {print sum}' "$file")
    avail_sum=$((avail_sum + avail_value))
    ((avail_count++))
  elif [[ $file == memory_usage_* ]]; then
    memory_av=$(awk -F': Used: |, Available: ' '{sum += $2} END {print sum}' "$file")
    memory_av_sum=$((memory_av_sum + memory_av))
    memory_used=$(awk -F '[: ,]+' '/Used/{print $2}' "$file")
    memory_used_sum=$((memory_used_sum + memory_used))
    ((memory_count++))
  elif [[ $file == cpu_utilization_* ]]; then
    cpu_value=$(awk -F': ' '{sum += $2} END {print sum}' "$file")
    cpu_sum=$((cpu_sum + cpu_value))
    ((cpu_count++))
  fi
done

# Calculate the average values
used_avg=0
if [[ $used_count -ne 0 ]]; then
  used_avg=$((used_sum / used_count))
fi

avail_avg=0
if [[ $avail_count -ne 0 ]]; then
  avail_avg=$((avail_sum / avail_count))
fi

memory_used_avg=$(echo "scale=2; $memory_used_sum / $memory_count" | bc)
memory_av_avg=$(echo "scale=2; $memory_av_sum / $memory_count" | bc)

cpu_avg=0
if [[ $cpu_count -ne 0 ]]; then
  cpu_avg=$(echo "scale=2; $cpu_sum / $cpu_count" | bc)
fi

# Display the average values
echo "Average Used Disk Space: $used_avg MB"
echo "Average Free Disk Space: $avail_avg MB"
echo "Average Memory Usage: $memory_used_avg GB"
echo "Average Memory Free: $memory_av_avg GB"
echo "Average CPU Utilization: $cpu_avg%"
