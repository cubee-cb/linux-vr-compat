#!/bin/bash

# change these to suit your system
card=card1 # check inside `/sys/class/drm/`; typically this would be `card0` unless you have multiple GPUs (e.g. iGPU + dGPU)
cpu_temp_sensor=k10temp-pci-00c3 # from `sensors`
gpu_temp_sensor=amdgpu-pci-1200 # from `sensors`

# https://stackoverflow.com/a/33826763
# Phrap's watch (LVRA): https://discord.com/channels/1065291958328758352/1388705420167741540/1388705420167741540
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -c|--cpu) echo CPU: $(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else printf "%.0f", ($2+$4-u1) * 100 / (t-t1) "%"; }' <(grep 'cpu ' /proc/stat) <(sleep .5;grep 'cpu ' /proc/stat))% ;;
        -g|--gpu) echo GPU: $(cat /sys/class/drm/$card/device/gpu_busy_percent)% ;;
        -r|--ram) echo RAM: $(free -m | awk 'NR==2{printf "%.0f%%", $3*100/$2 }') ;;
        -v|--vram) echo VRAM: $(printf %.0f $(bc <<< "scale=2;$(cat /sys/class/drm/card1/device/mem_info_vram_used)/$(cat /sys/class/drm/card1/device/mem_info_vram_total)*100"))% ;;
        -C|--cputemp) sensors $cpu_temp_sensor | grep 'Tctl' | awk '{ printf $2 }' | sed "s/+/CPU Tctl Temp: /g" ;;
        -G|--gputemp) sensors $gpu_temp_sensor | grep 'edge' | awk '{ printf $2 }' | sed 's/+/GPU Edge Temp: /g' ;;
        -R|--ramtemp) echo "RAM Temp: Not Implemented" ;;
        -V|--gputemp) sensors $gpu_temp_sensor | grep 'mem' | awk '{ printf $2 }' | sed 's/+/GPU VRAM Temp: /g' ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done
