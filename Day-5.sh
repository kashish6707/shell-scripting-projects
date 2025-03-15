#!/bin/bash
# Monitoring Metrics Script with Sleep Mechanism
#CPU usage, memory usage, and disk space usage.
#use awk, sed, grep

CPU_Usage(){
    usageCPU=$(top -l 1 | grep "CPU usage" |  awk '{print $2 $3}')
    echo "$usageCPU"

}

 Memory_usage(){
    usageMemory=$(free | grep "Memory")
    echo "$usageMemory"
 }

  disk_usage(){
    usageDisk=$(df -h | awk '{ print $1, $7}')
    echo "$usageDisk"
 }

option(){
    echo "choose option"
    echo "1:CPU Usage"
    echo "2:Memorary usage"
    echo "3:disk space usage"
    read -p "Enter your option  " opt
    if [[ "$opt" = 1 ]]; then
    CPU_Usage
    elif [[ "$opt" = 2 ]]; then
    Memory_usage
    else
    disk_usage
    fi
}

option
