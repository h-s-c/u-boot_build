export CROSS_COMPILE=aarch64-linux-gnu-

# build soquartz
cd u-boot
export ROCKCHIP_TPL="$(ls ../rkbin/bin/rk35/rk3566_ddr_1056MHz_v*.bin | sort | tail -n1)"
export BL31="$(ls ../rkbin/bin/rk35/rk3568_bl31_v*.elf | sort | tail -n1)"
make soquartz-cm4-rk3566_defconfig
make -j$(nproc)
mkdir -p ../bin/soquartz
cp u-boot-rockchip.bin ../bin/soquartz/
git reset --hard
git clean -f -d
unset ROCKCHIP_TPL
unset BL31
cd ..

# build jetson nano
cd u-boot
git apply ../patches/jetson-nano/*.patch
make p3450-0000_defconfig
make -j$(nproc)
mkdir -p ../bin/jetson-nano
cp u-boot.bin ../bin/jetson-nano/
git reset --hard
git clean -f -d
cd ..

# build hikey960
cd u-boot
make hikey960_defconfig
make -j$(nproc)
mkdir -p ../bin/hikey960
cp u-boot.bin ../bin/hikey960/
git reset --hard
git clean -f -d
cd ..

cd arm-trusted-firmware
make all fip PLAT=hikey960 BL33=../bin/hikey960/u-boot.bin SCP_BL2=../edk2-non-osi/Platform/Hisilicon/HiKey960/lpm3.img
cp build/hikey960/release/bl2.bin ../bin/hikey960/l-loader.bin
cp build/hikey960/release/fip.bin ../bin/hikey960/
git reset --hard
git clean -f -d
cd ..
