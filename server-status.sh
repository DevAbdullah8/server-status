#!/bin/bash

# ==========================================
# Server Performance Statistics Script
# File: server-stats.sh
# ==========================================

echo "========================================="
echo "       SERVER PERFORMANCE STATS"
echo "========================================="
echo ""

# ------------------------------------------
# Total CPU Usage
# ------------------------------------------
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used CPU: " 100 - $8 "%"}'
echo ""

# ------------------------------------------
# Total Memory Usage
# ------------------------------------------
echo "Memory Usage:"
free -m | awk 'NR==2{
    used=$3
    free=$4
    total=$2
    percent=(used/total)*100

    printf "Total: %d MB\n", total
    printf "Used : %d MB\n", used
    printf "Free : %d MB\n", free
    printf "Usage: %.2f%%\n", percent
}'
echo ""

# ------------------------------------------
# Total Disk Usage
# ------------------------------------------
echo "Disk Usage:"
df -h / | awk 'NR==2{
    printf "Total: %s\n", $2
    printf "Used : %s\n", $3
    printf "Free : %s\n", $4
    printf "Usage: %s\n", $5
}'
echo ""

# ------------------------------------------
# Top 5 Processes by CPU Usage
# ------------------------------------------
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo ""

# ------------------------------------------
# Top 5 Processes by Memory Usage
# ------------------------------------------
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo ""

echo "========================================="
echo "            END OF REPORT"
echo "========================================="
