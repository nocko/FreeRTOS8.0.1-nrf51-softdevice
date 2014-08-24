# FreeRTOS port to nrf51822+softdevice

## Description

This is a port of the simple FreeRTOS blinky demo. Critical region
handling has been updated to use the softdevice api.

Due to a lack of SysTick support in the nrf51 the tick timer is
implemented via RTC1. RTC1 also uses the LFCLK; so we don't need HFCLK
running during the IdleTask.

The vApplicationIdleHook is implemented to call sd_app_evt_wait(). So
it ought to sleep as well as can be expected.

## Questionable Decisions + Todos

I've configure the FreeRTOS tick with the app_timer api included in
the NRF SDK. It's probably be more efficient to configure and use RTC1
directly and simply `#define xSysTickHandler RTC1_IRQHander`. I chose
not to do this because nearly all the nordic demos rely on app_timer
functionality, which would break if I stole RTC1 away from it.

I've left some native NVIC_* calls where I don't think it'll matter
(e.g. disabling interrupt on unrecoverable errors).

Patches welcome, this code is PoC quality (at best).

## Prerequisites

- GCC (arm-eabi-none-gcc, et. al) in your path

- NRF SDK installed locally and the path specified as SDK_PATH in the
  Makefile

- NRF Softdevice loaded onto the development board.

- Tested with s120v1 and SDK 6.0.0

## Usage

1. Edit Makefile as needed. You'll also want to correct the LED_0
   definition in main.c to correspond to your development boards LED.

2. Flash softdevice

3. `make flash`

## Credits

- Build environment based heavily on
  [hlnd/nrf51-pure-gcc-setup](https://github.com/hlnd/nrf51-pure-gcc-setup)

- Heavily influenced by the existing FreeRTOS Demo: CORTEX_LM3S102_GCC
  and the existing FreeRTOS ARM_CM0 code.
