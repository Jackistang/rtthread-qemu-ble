#!/bin/bash

function println() {
  echo -e "\033[32m$1\033[0m"
}

# 安装 bluez 依赖环境，可能有缺失，需要及时更新
println "Installing bluez dependency"
sudo apt install -y git bc libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev autoconf bison flex libssl-dev libjson-c-dev
sudo apt install automake libtool libelf-dev elfutils libdw-dev libjson-c-dev libical-dev libreadline-dev libdbus-1-dev libudev-dev
println "Installing bluez dependency success"

# 安装 bluez 依赖项目 ell，需与 bluez 处于同一目录下
cd ~
if [ ! -d ell ];
then
  println "Installing ell"
  git clone -b 0.35 git://git.kernel.org/pub/scm/libs/ell/ell.git
  println "Installing success"
fi

# 安装 Bluez
cd ~
if [ ! -d bluez ];
then
  println "Installing bluez"
  git clone -b 5.55 https://github.com/bluez/bluez.git
  cd bluez
  ./bootstrap-configure --disable-android --disable-midi
  make
  sudo systemctl daemon-reload
  sudo systemctl restart bluetooth
  println "Installing success"
fi

# 安装 rtthread linux 环境
sudo apt install -y libncurses5-dev python3
pip3 install scons

cd /tmp/
if [ ! -d /opt/gcc-arm-none-eabi-6_2-2016q4 ];
then
  if [ ! -d gcc-arm-none-eabi-6_2-2016q4 ];
  then
    wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/6-2016q4/gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
    tar xf ./gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
  fi
  sudo mv gcc-arm-none-eabi-6_2-2016q4/ /opt/
  /opt/gcc-arm-none-eabi-6_2-2016q4/bin/arm-none-eabi-gcc --version
fi

# 安装 qemu
# ubuntu 20.04 之后将 qemu-system-arm 剥离出了 qemu，需要单独安装
sudo apt install -y qemu-system-arm
if [ ! $? -eq 0 ];
then
  sudo apt install qemu
fi
