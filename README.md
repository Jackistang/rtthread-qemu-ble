# rtthread qemu 环境运行 ble

该工程目前在 ubuntu 20.04 环境下运行良好，其他版本的环境待测试，若发现问题欢迎提 issue 。

利用 qemu 环境运行 ble，不使用使用外接的蓝牙芯片，直接使用物理机自带的蓝牙控制器，同时也不需要下载固件，对于测试学习蓝牙应用开发十分方便。在开始运行该工程前，需在命令行输入 `hciconfig` 命令确保物理机有 `hci0` 蓝牙控制器。若为其他蓝牙控制器，例如 hci1, hci2 等等，请根据注释修改 `qemu-ble.sh` 文件。

该工程使用 NimBLE 的 Host 协议栈，并运行 ble_hr 例程。

```shell
jackis@jackis:~/C/rtthread-qemu-ble$ hciconfig
hci0:	Type: Primary  Bus: USB
	BD Address: 00:00:00:00:00:00  ACL MTU: 27:7  SCO MTU: 0:0
	UP RUNNING 
	RX bytes:1854 acl:0 sco:0 events:107 errors:0
	TX bytes:1218 acl:17 sco:0 commands:134 errors:1
```



**环境搭建（最好能科学上网）：**

```shell
git clone --recursive https://github.com/Jackistang/rtthread-qemu-ble.git
cd rtthread-qemu-ble
sudo ./build.sh
```

**编译：**

```shell
scons
```

**运行** rtthread-qemu，然后在 msh 终端里输入 `ble_hr` 命令即可。

```shell
./qemu-ble.sh

msh />ble_hr
```

键入 `Ctrl a + Ctrl x` 退出 qemu 环境。

**VSCode 调试：**

键入 `Ctrl+Alt+J` 打开 VSCode 终端，在终端运行里 `qemu-ble-dbg.sh` 文件，开启 gdb server；然后按 `F5`，VSCode 自动进行编译调试。

**使用H4协议蓝牙芯片**

该运行环境还支持接入 H4 协议的蓝牙芯片，不需要 bluez 的环境搭建。将芯片通过串口接入电脑，获取实际的串口设备 /dev/ttyXXX，然后运行：

```shell
qemu-system-arm -M vexpress-a9 -smp cpus=2 -kernel rtthread.bin -nographic -serial mon:stdio -serial /dev/ttyXXX
```

**注意**：该方式目前仅在 linux 环境测试成功，windows 环境不可用。

## 常用固件

一些常用的蓝牙 Controller 固件可以在 firmwares 目录下找到，若有其他需要的固件可以提 issue，我会及时添加。

------

**reference:**

- [Bluetooth tools](https://docs.zephyrproject.org/latest/connectivity/bluetooth/bluetooth-tools.html)
- [Step-by-Step Guide: How to Deploy BlueZ v5.50 on Raspberry Pi 3 and Use It](https://www.bluetooth.com/bluetooth-resources/developer-study-guide-how-to-deploy-bluez-on-a-raspberry-pi-board-as-a-bluetooth-mesh-provisioner/)
