#!/bin/sh
cd linux_app
#tar -xzvpf zynq_lib.tar.gz -C /tmp > /dev/null
tar -xzvpf zynq_lib.tar.gz -C /tmp
cd /tmp/zynq_lib
source lib.sh
cd /sd/linux_app
./osci_ad9226


