#!/bin/bash

# 安装 bluez 依赖环境，可能有缺失，需要及时更新
echo "Installing bluez dependency"
sudo apt-get install -y git bc libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev autoconf bison flex libssl-dev libjson-c-dev
echo "Installing bluez dependency success"

# 安装 bluez 依赖项目 ell，需与 bluez 处于同一目录下
cd ~
if ! [ [ -d ell-0.6 ] && [ -d ell ] ];
then
  echo "Installing ell"
  wget https://mirrors.edge.kernel.org/pub/linux/libs/ell/ell-0.6.tar.xz
  tar -xvf ell-0.6.tar.xz
  cd ell-0.6/
  ./configure --prefix=/usr
  make
  sudo make install
  echo "Installing success"
fi

# 安装 Bluez
cd ~
if ! [ [ -d bluez-5.50 ] && [ -d bluez ] ];
then
  echo "Installing bluez"
  wget http://www.kernel.org/pub/linux/bluetooth/bluez-5.50.tar.xz 
  tar -xvf bluez-5.50.tar.xz 
  cd bluez-5.50/
  ./bootstrap-configure --disable-android --disable-midi
  make
  sudo systemctl daemon-reload
  sudo systemctl restart bluetooth
  echo "Installing success"
fi

# 安装 rtthread linux 环境
sudo apt install libncurses5-dev python3
pip3 install scons

cd /tmp/
if ! [ -d gcc-arm-none-eabi-6_2-2016q4 ];
then
  wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/6-2016q4/gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
  tar xf ./gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
  mv gcc-arm-none-eabi-6_2-2016q4/ /opt/
  /opt/gcc-arm-none-eabi-6_2-2016q4/bin/arm-none-eabi-gcc --version
fi

# 安装 qemu
# ubuntu 20.04 之后将 qemu-system-arm 剥离出了 qemu，需要单独安装
sudo apt install qemu-system-arm
if ! [ $? -eq 0 ];
then
  sudo apt install qemu
fi