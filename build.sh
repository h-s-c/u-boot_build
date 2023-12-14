export CROSS_COMPILE=aarch64-linux-gnu-

# build soquartz
cd u-boot
export ROCKCHIP_TPL="$(ls ../rkbin/bin/rk35/rk3566_ddr_1056MHz_v*.bin | sort | tail -n1)"
export BL31="$(ls ../rkbin/bin/rk35/rk3568_bl31_v*.elf | sort | tail -n1)"
#git apply ../patches/soquartz/*.patch
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