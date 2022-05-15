# rtthread qemu 环境运行 ble

该工程目前在 ubuntu 20.04 环境下运行良好，其他版本的环境待测试，若发现问题欢迎提 issue 。

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