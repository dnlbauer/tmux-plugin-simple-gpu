#!/usr/bin/env bash

print_gpu_usage() {
    function getGPUUsage() {
	    gpuUsage=($(nvidia-smi -q -d UTILIZATION | grep Gpu | awk '{print $3}'))
    }
    getGPUUsage
    gpuUsage=("${gpuUsage[@]/%/%}")
    
    function join_by { local IFS="$1"; shift; echo "$*"; }
    gpuUsage=`join_by " " ${gpuUsage[@]}`
    if [ -z "$gpuUsage" ]; then
	echo "-"
    else
	echo "$gpuUsage"
    fi
}

main() {
  print_gpu_usage
}

main
