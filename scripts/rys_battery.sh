#!/bin/zsh

let v1=$(( `cat /sys/devices/platform/ocp/44e0d000.tscadc/TI-am335x-adc/iio:device0/in_voltage3_raw` / 734.4895 ))
let v2=$(( `cat /sys/devices/platform/ocp/44e0d000.tscadc/TI-am335x-adc/iio:device0/in_voltage1_raw` / 340.7509 ))
let v3=$(( `cat /sys/devices/platform/ocp/44e0d000.tscadc/TI-am335x-adc/iio:device0/in_voltage6_raw` / 214.1773 ))

let c1=$v1
let c2=$(($v2 - $v1))
let c3=$(($v3 - $v2))

echo "Cell1: $c1"
echo "Cell2: $c2"
echo "Cell3: $c3"
