# FreeRTOS Flash demo port to nrf51822+softdevice

## Description

This is a port of the simple FreeRTOS blinky demo. Critical region
handling has been updated to use the softdevice api.

Due to a lack of SysTick hardware in the nrf51 the tick timer is
implemented via RTC1. RTC1 auses the LFCLK; so we don't need HFCLK
running most of the time.

The vApplicationIdleHook is implemented to call sd_app_evt_wait(). So
it ought to sleep as well as can be expected.

## Questionable Decisions + Todos

I've configure the FreeRTOS tick with the app_timer api included in
the NRF SDK. It's probably be more efficient to configure and use RTC1
directly and simply `#define xSysTickHandler RTC1_IRQHander`. I chose
not to do this because nearly all the nordic demos rely on app_timer
functionality, which would break if I stole RTC1 away from it.

I've left some native NVIC_* calls / disable interrupt macros where I don't think it'll matter (e.g. disabling interrupt on unrecoverable errors).

I've reduced the default call stack size do a few hundred bytes above the ~1600 required for softdevice operation (down from 0xC00). This was needed to free up some additional heap so that the queue tasks could be allocated. Additional tuning is surely required. There's only ~5kB of RAM left after the s120 softdevice has it's way; so careful consideration is needed.

Patches welcome, this code is PoC quality (at best).

## Prerequisites

- GCC ARM Toolchain (arm-eabi-none-gcc, et. al) in your path

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

- Heavily influenced by the existing FreeRTOS Flash Demo and the existing FreeRTOS ARM_CM0 code.
