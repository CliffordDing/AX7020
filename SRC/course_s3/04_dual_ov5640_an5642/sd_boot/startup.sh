#!/bin/sh
cd linux_app
tar -xzvpf zynq_lib.tar.gz -C /tmp > /dev/null
cd /tmp/zynq_lib
source lib.sh
cd /sd/linux_app
./an5642_opencv_test


