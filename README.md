# rtthread qemu 环境运行 ble

该工程目前在 ubuntu 20.04 环境下运行良好，其他版本的环境待测试，若发现问题欢迎提 issue 。

利用 qemu 环境运行 ble，不使用使用外接的蓝牙芯片，直接使用物理机自带的蓝牙控制器，同时也不需要下载固件，对于测试学习蓝牙应用开发十分方便。在开始运行该工程前，需在命令行输入 `hciconfig` 命令确保物理机有 `hci0` 蓝牙控制器。若为其他蓝牙控制器，例如 hci1, hci2 等等，请根据注释修改 `qemu-ble.sh` 文件。

```shell
jackis@jackis:~/C/rtthread-qemu-ble$ hciconfig
hci0:	Type: Primary  Bus: USB
	BD Address: 00:00:00:00:00:00  ACL MTU: 27:7  SCO MTU: 0:0
	UP RUNNING 
	RX bytes:1854 acl:0 sco:0 events:107 errors:0
	TX bytes:1218 acl:17 sco:0 commands:134 errors:1
```



环境搭建（最好能科学上网）：

```shell
git clone https://github.com/Jackistang/rtthread-qemu-ble.git
cd rtthread-qemu-ble
./build.sh
```

编译：

```shell
scons
```

运行 rtthread-qemu，然后在 msh 终端里输入 `ble_hr` 命令即可。

```shell
./qemu-ble.sh

msh />ble_hr
```

键入 `Ctrl a + Ctrl x` 退出 qemu 环境。

------

reference:

- [Bluetooth tools](https://docs.zephyrproject.org/latest/connectivity/bluetooth/bluetooth-tools.html)
- [Step-by-Step Guide: How to Deploy BlueZ v5.50 on Raspberry Pi 3 and Use It](https://www.bluetooth.com/bluetooth-resources/developer-study-guide-how-to-deploy-bluez-on-a-raspberry-pi-board-as-a-bluetooth-mesh-provisioner/)