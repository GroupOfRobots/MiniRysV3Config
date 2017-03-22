cd ~/RobotConfig
nano /boot/uEnv.txt add line dtb=am335x-bonegreen-wireless.dtb
cp DevTree/am335x-bonegreen-wireless.dts /opt/source/dtb-4.4-ti/src/arm
cp DevTree/am335x-bonegreen-irys.dtsi /opt/source/dtb-4.4-ti/src/arm

cd /opt/source/dtb-4.4-ti 
make 
make install
cd ~/RobotConfig
echo BB-ADC > /sys/devices/platform/bone_capemgr/slots

cp PRUfirmware/*.out /lib/firmware

ln -s /lib/firmware/PRU_RPMsg_Echo_Interrupt0.out /lib/firmware/am335x-pru0-fw
ln -s /lib/firmware/PRU_RPMsg_Echo_Interrupt1.out /lib/firmware/am335x-pru1-fw

cp scripts/initial.sh /usr/bin
cp scripts/startup.service /etc/systemd/system

chmod 744 /usr/bin/initial.sh
chmod 664 /etc/systemd/system/startup.service
systemctl daemon-reload
systemctl enable startup.service
systemctl start startup.service

systemctl stop apache2.service
systemctl disable apache2.service

systemctl stop pulseaudio.service
systemctl disable pulseaudio.service

systemctl stop cloud9.socket 
systemctl disable cloud9.socket

systemctl stop wificonfig.service
systemctl disable wificonfig.service

apt-get remove nodejs


