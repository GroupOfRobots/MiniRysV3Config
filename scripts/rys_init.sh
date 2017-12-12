#!/bin/sh -e

# PRUs - /dev/rpmsg_*
# Cycle the module to force reload firmware
/sbin/modprobe -r pru_rproc
sleep .3
/sbin/modprobe  pru_rproc
# Wait for /dev/rpmsg* to become available
sleep 1
# Add access permissions for user
chown root:rpmsg /dev/rpmsg_pru30
chown root:rpmsg /dev/rpmsg_pru31
chmod 660 /dev/rpmsg_pru30
chmod 660 /dev/rpmsg_pru31

# VL53L0X enables
echo 50 > /sys/class/gpio/export
echo 51 > /sys/class/gpio/export
echo 66 > /sys/class/gpio/export
echo 67 > /sys/class/gpio/export
echo 69 > /sys/class/gpio/export

echo "out" > /sys/class/gpio/gpio50/direction
echo "out" > /sys/class/gpio/gpio51/direction
echo "out" > /sys/class/gpio/gpio66/direction
echo "out" > /sys/class/gpio/gpio67/direction
echo "out" > /sys/class/gpio/gpio69/direction

echo 0 > /sys/class/gpio/gpio50/value
echo 0 > /sys/class/gpio/gpio51/value
echo 0 > /sys/class/gpio/gpio66/value
echo 0 > /sys/class/gpio/gpio67/value
echo 0 > /sys/class/gpio/gpio69/value

# DWM1000 enable and IRQ
echo 115 > /sys/class/gpio/export
echo 20 > /sys/class/gpio/export

echo "out" > /sys/class/gpio/gpio115/direction
echo "in" > /sys/class/gpio/gpio20/direction

echo 0 > /sys/class/gpio/gpio115/value

#echo none > /sys/class/leds/beaglebone:green:usr0/trigger
#echo none > /sys/class/leds/beaglebone:green:usr1/trigger
#echo none > /sys/class/leds/beaglebone:green:usr2/trigger
#echo none > /sys/class/leds/beaglebone:green:usr3/trigger
