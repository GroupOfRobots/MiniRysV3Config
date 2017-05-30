#edit uEnv.txt add line dtb=am335x-bonegreen-wireless.dtb
cp am335x-bonegreen-wireless.dts /opt/source/dtb-4.4-ti/src/arm
cp am335x-bonegreen-irys.dtsi /opt/source/dtb-4.4-ti/src/arm

cd /opt/source/dtb-4.4-ti 
make 
make install

#compile dev-tree BB_BONE_IRYS to enable ADC and SPI 

dtc -O dtb -o BB_BONE_IRYS.dtbo -b 0 -@ BB_BONE_IRYS.dts
#move compiled to /lib/firmware and echo 
echo BB-BONE-IRYS > /sys/devices/platform/bone_capemgr/slots

#lub samo adc 

echo BB-ADC > /sys/devices/platform/bone_capemgr/slots
