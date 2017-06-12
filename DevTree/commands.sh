#edit /boot/uEnv.txt: add line dtb=am335x-bonegreen-wireless.dtb
cp am335x-bonegreen-wireless.dts /opt/source/dtb-4.9-ti/src/arm
cp am335x-bonegreen-irys.dtsi /opt/source/dtb-4.9-ti/src/arm

cd /opt/source/dtb-4.9-ti
make
sudo make install
