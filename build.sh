#!/bin/bash

# Shell 脚本里命令执行出错后自动退出
set -e

function println() {
  echo -e "\033[32m$1\033[0m"
}

# 安装 bluez 依赖环境，可能有缺失，需要及时更新
println "Installing bluez dependency"
apt install -y git bc libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev autoconf bison flex libssl-dev automake libtool libelf-dev elfutils libdw-dev libncurses5
println "Installing bluez dependency success"

# ubuntu 18.04 用 apt 安装的 json-c 版本过低，单独安装
if [ ! -d ~/json-c ];
then
  cd ~
  git clone -b json-c-0.15-20200726 https://github.com/json-c/json-c.git && cd json-c \
    && mkdir build && cd build \
    && cmake .. \
    && make \
    && make install
fi

# 安装 bluez 依赖项目 ell，需与 bluez 处于同一目录下
if [ ! -d ~/ell ];
then
  cd ~
  println "Installing ell"
  git clone -b 0.35 git://git.kernel.org/pub/scm/libs/ell/ell.git
  println "Installing success"
fi

# 安装 Bluez
if [ ! -d ~/bluez ];
then
  cd ~
  println "Installing bluez"
  git clone -b 5.55 https://github.com/bluez/bluez.git
  cd bluez
  ./bootstrap-configure --disable-android --disable-midi --disable-mesh
  make
  systemctl daemon-reload
  systemctl restart bluetooth
  println "Installing success"
fi

# 安装 rtthread linux 环境
apt install -y libncurses5-dev python3
pip3 install scons

if [ ! -d /opt/gcc-arm-none-eabi-6_2-2016q4 ];
then
  cd /tmp/
  if [ ! -d /tmp/gcc-arm-none-eabi-6_2-2016q4 ];
  then
    wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/6-2016q4/gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
    tar xf ./gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
  fi
  mv gcc-arm-none-eabi-6_2-2016q4/ /opt/
  /opt/gcc-arm-none-eabi-6_2-2016q4/bin/arm-none-eabi-gcc --version
fi

# 安装 qemu
# ubuntu 20.04 之后将 qemu-system-arm 剥离出了 qemu，需要单独安装
if ! apt install -y qemu-system-arm;
then
  apt install qemu
fi

println "Install environment success"