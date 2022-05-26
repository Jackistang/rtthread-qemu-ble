# 常用的蓝牙控制器固件

这些固件都是我在 Zephyr 环境编译生成的，使用稳定。


### hci_uart_nrf52840dk.hex

![nrf52840dk](./images/nrf52840dk.png)

该固件使用的是 [nrf52840dk](https://www.nordicsemi.com/Products/Development-hardware/nrf52840-dk) 开发板，HCI 传输层为 H4 协议，波特率 115200，使用硬件控制流 CTS/RTS。

**Windows** 平台下载该固件比较简单，将 nrf52840dk 插入电脑，电脑会自动识别一个 `JLINK` U 盘，用鼠标将固件拖入该 U 盘即可。

![JLINK U 盘](./images/JLINK_U.png)

**Linux** 平台下载该固件较为麻烦，需要使用工具 [J-Link Software and documentation pack](https://www.segger.com/downloads/jlink/) 和 [nRF Command Line Tools](https://www.nordicsemi.com/Products/Development-tools/nrf-command-line-tools)

下载固件流程：

1. 擦除芯片内程序

```shell
nrfjprog --eraseall -f nrf52
```

2. 写入固件

```shell
nrfjprog --program hci_uart_nrf52840dk.hex -f nrf52
```

3. 复位并启动

```shell
nrfjprog --reset -f nrf52
```

可参考：[nordic-segger](https://docs.zephyrproject.org/latest/develop/flash_debug/nordic_segger.html#nordic-segger)

### hci_uart_nrf52832dk.hex

![nrf52dk_nrf52832](./images/nrf52dk_nrf52832.jpg)

该固件使用的是 [nrf52832dk](https://www.nordicsemi.com/Products/Development-hardware/nRF52-DK) 开发板，HCI 传输层为 H4 协议，波特率 115200，使用硬件控制流 CTS/RTS。

固件下载与 [hci_uart_nrf52840dk.hex](###hci_uart_nrf52840dk.hex) 的方式一致。

### hci_usb_nrf52840dongle.hex

![nrf52840dongle](./images/nrf52840dongle.png)

该固件使用的是 [nrf52840dongle](https://www.nordicsemi.com/Products/Development-hardware/nrf52840-dongle) 开发板，HCI 传输层为 USB 协议。


下载该固件需要使用 [nRF Util](https://www.nordicsemi.com/Products/Development-tools/nRF-Util)，输入 `pip3 install nrfutil` 即可安装。

下载固件：

1. 按下 RESET 按钮进入 bootloader
2. 利用 nrfutil 打包固件

```shell
nrfutil pkg generate --hw-version 52 --sd-req=0x00 \
        --application hci_usb_nrf52840dongle.hex \
        --application-version 1 hci_usb_nrf52840dongle.zip
```

3. 写入固件，注意 Linux 环境下使用 `/dev/ttyXXX` 设备，Windows 使用 `COMx`，macOS 也类似。

```shell
nrfutil dfu usb-serial -pkg hci_usb_nrf52840dongle.zip -p /dev/ttyACM0
```


可参考：[Zephyr-nrf52840dongle](https://docs.zephyrproject.org/latest/boards/arm/nrf52840dongle_nrf52840/doc/index.html)