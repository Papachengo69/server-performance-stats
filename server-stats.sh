#!/bin/bash

echo "----------------------------------------"
echo "🖥️  SERVER PERFORMANCE STATS"
echo "----------------------------------------"

# OS Info
echo ""
echo "🧰 OS Information:"
uname -a

# Uptime
echo ""
echo "⏱️ Uptime:"
uptime -p

# Load Average
echo ""
echo "📊 Load Average (1m, 5m, 15m):"
uptime | awk -F'load average:' '{ print $2 }'

# Logged in users
echo ""
echo "👥 Logged in users:"
who | wc -l

# CPU Usage
echo ""
echo "🧠 Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print "Used: " $2+$4 "%, Idle: " $8 "%"}'

# Memory Usage
echo ""
echo "🧵 Total Memory Usage:"
free -h | awk '/Mem:/ {print "Used: "$3", Free: "$4", Total: "$2}'
free | awk '/Mem:/ {
  used=$3; total=$2;
  percent=used*100/total;
  printf("Percentage Used: %.2f%%\n", percent);
}'

# Disk Usage
echo ""
echo "💽 Total Disk Usage:"
df -h --total | grep 'total' | \
awk '{print "Used: "$3", Free: "$4", Total: "$2", Usage: "$5}'

# Top 5 processes by CPU usage
echo ""
echo "🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory usage
echo ""
echo "💾 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Failed login attempts (optional stretch)
echo ""
echo "🚨 Failed Login Attempts:"
journalctl _SYSTEMD_UNIT=sshd.service | grep "Failed password" | wc -l

echo ""
echo "✅ Stats collected successfully!"
