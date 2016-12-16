#!/bin/bash -e

/sbin/modprobe -r pru_rproc
sleep .3
/sbin/modprobe  pru_rproc

if [ ! -d /sys/class/gpio/gpio78 ]; then echo 78 > /sys/class/gpio/export; fi
if [ ! -d /sys/class/gpio/gpio79 ]; then echo 79 > /sys/class/gpio/export; fi


echo out > /sys/class/gpio/gpio78/direction
echo out > /sys/class/gpio/gpio79/direction


echo 1 > /sys/class/gpio/gpio78/value
echo 1 > /sys/class/gpio/gpio79/value

