#!/usr/bin/env bash

print_gpu_usage() {
    function getVRAMUsage() {
	    vramTotal=($(nvidia-smi -q -d MEMORY | grep Total | awk '{print $3}'))
	    vramUsed=($(nvidia-smi -q -d MEMORY | grep Used | awk '{print $3}'))

	    vramUsage=()
	    for (( i=0; i<${#vramTotal[@]}; i=$((i+2)) )); do
		    vramUsage+=( $((vramUsed[$i] * 100 / vramTotal[$i])) )
	    done
    }
    getVRAMUsage
    gpuUsage=("${vramUsage[@]/%/%}")
    
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
