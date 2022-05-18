/*
 * Copyright (c) 2006-2020, RT-Thread Development Team
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Change Logs:
 * Date           Author       Notes
 * 2020/12/31     Bernard      Add license info
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define __REG32(x)  (*((volatile unsigned int *)(x)))
#define REALVIEW_UART1_BASE         0x1000A000  /* UART 1 */

#define UART_CR(base)   __REG32(base + 0x30)

#define UARTCR_RTSEN    (1 << 14)
#define UARTCR_CTSEN    (1 << 15)

int main(void)
{
    printf("Hello RT-Thread!\n");

    printf("UARTCR1_RTSEN: %u\n", (UART_CR(REALVIEW_UART1_BASE) & UARTCR_RTSEN) != 0);
    printf("UARTCR1_CTSEN: %u\n", (UART_CR(REALVIEW_UART1_BASE) & UARTCR_CTSEN) != 0);

    return 0;
}
