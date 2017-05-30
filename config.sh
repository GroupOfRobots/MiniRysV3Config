#!/bin/bash

rys_ip=$1

if [[ $rys_ip == "" ]] ; then
	echo "Usage: ${0} <ip_address>"
	exit 1
fi

ssh -q root@$rys_ip exit
if [[ $(echo $?) == 0 ]] ; then
	echo "Host is reachable, continuing..."
else
	echo "Host cannot be reached. Check IP address and connectivity"
	exit 2
fi

# -t is for allocating TTY
ssh -t -t root@$rys_ip '/bin/bash' << EOF

echo "Cloning into RobotConfig..."
git clone https://github.com/GroupOfRobots/RobotConfig

cd ~/RobotConfig
git checkout v3

echo "Installing robot Device Tree (overlay)..."
cp DevTree/am335x-bonegreen-wireless-irys.dts /opt/source/dtb-4.4-ti/src/arm/
cp DevTree/am335x-bonegreen-irys.dtsi /opt/source/dtb-4.4-ti/src/arm/

cd /opt/source/dtb-4.4-ti
make
make install
echo dtb=am335x-bonegreen-wireless.dtb >> /boot/uEnv.txt

echo "Enabling ADC..."
cd ~/RobotConfig
echo BB-ADC > /sys/devices/platform/bone_capemgr/slots

echo "Installing PRU firmware..."
echo "[[TODO!!!]]"
#cp PRUfirmware/*.out /lib/firmware

#ln -s /lib/firmware/PRU_RPMsg_Echo_Interrupt0.out /lib/firmware/am335x-pru0-fw
#ln -s /lib/firmware/PRU_RPMsg_Echo_Interrupt1.out /lib/firmware/am335x-pru1-fw

echo "Installing systemd service..."
cp scripts/rys_init.sh /usr/bin/rys_init.sh
cp scripts/rys_startup.service /etc/systemd/system/rys_startup.service

chmod 744 /usr/bin/rys_init.sh
chmod 664 /etc/systemd/system/rys_startup.service
systemctl daemon-reload
echo "Enabling and starting systemd service..."
systemctl enable rys_startup.service
systemctl start rys_startup.service

echo "Disabling unneeded default BBGW services..."
systemctl stop apache2.service
systemctl disable apache2.service

systemctl stop pulseaudio.service
systemctl disable pulseaudio.service

systemctl stop cloud9.socket
systemctl disable cloud9.socket

systemctl stop wificonfig.service
systemctl disable wificonfig.service

echo "Done, rebooting in 3!"
sleep 3
systemctl reboot -i

exit 0

EOF
