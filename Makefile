RTOS_SOURCE_DIR=./src

LIBRARY_PATHS += .
LIBRARY_PATHS += ./include
LIBRARY_PATHS += ${RTOS_SOURCE_DIR}/portable/GCC/NRF51_SD 

SOURCE_PATHS += ${RTOS_SOURCE_DIR}
SOURCE_PATHS += ${RTOS_SOURCE_DIR}/portable/MemMang
SOURCE_PATHS += ${RTOS_SOURCE_DIR}/portable/GCC/NRF51_SD

# List all source files the application uses.
APPLICATION_SRCS = $(notdir $(wildcard ./*.c))
APPLICATION_SRCS += softdevice_handler.c

#FreeRTOS Sources
APPLICATION_SRCS += list.c
APPLICATION_SRCS += queue.c
APPLICATION_SRCS += tasks.c
APPLICATION_SRCS += port.c
APPLICATION_SRCS += heap_1.c
#APPLICATION_SRCS += timers.c

PROJECT_NAME = FreeRTOS-Demo

DEVICE = NRF51

USE_SOFTDEVICE = s120

SDK_PATH = $(HOME)/devel/nrf-sdk-6.0.0/nrf51822/
TEMPLATE_PATH = ./template/

CFLAGS = -Os -g -Wall
LDFLAGS = --specs=nano.specs

GDB_PORT_NUMBER = 2331

include $(TEMPLATE_PATH)Makefile
