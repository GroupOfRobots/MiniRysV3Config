#!/bin/bash

readonly maxValue=3360
readonly minValue=2500
readonly step=215

readonly analogInput="/sys/devices/platform/ocp/44e0d000.tscadc/TI-am335x-adc/iio:device0/in_voltage5_raw"
readonly led0="/sys/class/leds/beaglebone:green:usr0/brightness"
readonly led1="/sys/class/leds/beaglebone:green:usr1/brightness"
readonly led2="/sys/class/leds/beaglebone:green:usr2/brightness"
readonly led3="/sys/class/leds/beaglebone:green:usr3/brightness"

readonly step1=$(($minValue+$step))
readonly step2=$(($minValue+2*$step))
readonly step3=$(($minvalue+3*$step))


batteryVoltage=$(cat "$analogInput")

#-le <=

if [ "$batteryVoltage" -le "$minValue" ]
then
	echo 0 > $led0	
	echo 0 > $led1
	echo 0 > $led2
	echo 0 > $led3

elif [ "$batteryVoltage" -le "$step1" ]
then
	echo 1 > $led0	
	echo 0 > $led1
	echo 0 > $led2
	echo 0 > $led3

elif [ "$batteryVoltage" -le "$step2" ] 
then
	echo 1 > $led0	
	echo 1 > $led1
	echo 0 > $led2
	echo 0 > $led3	
			
elif [ "$batteryVoltage" -le "$step3" ]
then
	echo 1 > $led0	
	echo 1 > $led1
	echo 1 > $led2
	echo 0 > $led3
				
else
	echo 1 > $led0	
	echo 1 > $led1
	echo 1 > $led2
	echo 1 > $led3
fi

