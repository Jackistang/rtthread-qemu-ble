#!/bin/bash

set -e

if [ ! -f "sd.bin" ]; then
dd if=/dev/zero of=sd.bin bs=1024 count=65536
fi

# 关闭 hci0 设备，需替换为实际的 hci 设备，用 hciconfig 命令查看
# $ hciconfig
# hci0:	Type: Primary  Bus: USB
# 	BD Address: 00:00:00:00:00:00  ACL MTU: 27:7  SCO MTU: 0:0
# 	UP RUNNING 
# 	RX bytes:514 acl:0 sco:0 events:45 errors:0
# 	TX bytes:233 acl:0 sco:0 commands:45 errors:0
sudo hciconfig hci0 down

# 为 hci0 设备创建 unix socket 代理，并在子进程中运行，-i 0 代表 hci0 设备
# bluez 需安装在用户家用目录 ~ 下，否则需手动修改
# 建立新的子进程来运行该命令
sudo ~/bluez/tools/btproxy -u -i 0 &

qemu-system-arm -M vexpress-a9 -smp cpus=2 -kernel rtthread.bin -nographic -sd sd.bin -serial mon:stdio -serial unix:/tmp/bt-server-bredr -S -s