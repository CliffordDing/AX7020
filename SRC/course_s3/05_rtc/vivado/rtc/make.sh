#!/bin/sh
source /opt/Xilinx/SDK/2015.4/settings64.sh
arm-xilinx-linux-gnueabi-gcc rtc.c -o rtc -static
