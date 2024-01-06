export L4T_RELEASE_PACKAGE="jetson-210_linux_r32.7.1_aarch64.tbz2"
export SW_VERSION="r35.4.1"

cd bin/jetson-nano
wget -nc https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t210/${L4T_RELEASE_PACKAGE}
echo Extracting ${L4T_RELEASE_PACKAGE}
tar xf ${L4T_RELEASE_PACKAGE}
docker pull nvcr.io/nvidia/jetson-linux-flash-x86:${SW_VERSION}
docker run -t --privileged --net=host -v /dev/bus/usb:/dev/bus/usb -v ./:/workspace nvcr.io/nvidia/jetson-linux-flash-x86:${SW_VERSION} bash /workspace/Linux_for_Tegra/flash.sh -B ./u-boot.bin p3448-0000-max-spi external
cd ../..