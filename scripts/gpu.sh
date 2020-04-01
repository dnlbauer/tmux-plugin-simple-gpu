#!/usr/bin/env bash

print_gpu_usage() {
    function getGPUUsage() {
        gpuUsage=$(nvidia-smi -q -d UTILIZATION | grep Gpu | awk '{print $3}')
    }
    getGPUUsage
    if [ -z "$GpuUsage" ]; then
        echo "$gpuUsage%"
    else
	echo "-"
    fi
}

main() {
  print_gpu_usage
}

main
