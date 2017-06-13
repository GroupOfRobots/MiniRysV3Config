#!/bin/bash -e

/sbin/modprobe -r pru_rproc
sleep .3
/sbin/modprobe  pru_rproc

# MiniRys v3: VL53L0X enable pins
if [ ! -d /sys/class/gpio/gpio88 ]; then echo 88 > /sys/class/gpio/export; fi
if [ ! -d /sys/class/gpio/gpio66 ]; then echo 66 > /sys/class/gpio/export; fi
if [ ! -d /sys/class/gpio/gpio67 ]; then echo 67 > /sys/class/gpio/export; fi
if [ ! -d /sys/class/gpio/gpio68 ]; then echo 68 > /sys/class/gpio/export; fi
if [ ! -d /sys/class/gpio/gpio69 ]; then echo 69 > /sys/class/gpio/export; fi

echo out > /sys/class/gpio/gpio88/direction
echo out > /sys/class/gpio/gpio66/direction
echo out > /sys/class/gpio/gpio67/direction
echo out > /sys/class/gpio/gpio68/direction
echo out > /sys/class/gpio/gpio69/direction

echo 0 > /sys/class/gpio/gpio88/value
echo 0 > /sys/class/gpio/gpio66/value
echo 0 > /sys/class/gpio/gpio67/value
echo 0 > /sys/class/gpio/gpio68/value
echo 0 > /sys/class/gpio/gpio69/value

#echo none > /sys/class/leds/beaglebone:green:usr0/trigger
#echo none > /sys/class/leds/beaglebone:green:usr1/trigger
#echo none > /sys/class/leds/beaglebone:green:usr2/trigger
#echo none > /sys/class/leds/beaglebone:green:usr3/trigger

