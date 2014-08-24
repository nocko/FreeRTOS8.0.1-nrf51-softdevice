#******************************************************************************
#
# Makefile - Rules for building the driver library and examples.
#
# Copyright (c) 2005,2006 Luminary Micro, Inc.  All rights reserved.
#
# Software License Agreement
#
# Luminary Micro, Inc. (LMI) is supplying this software for use solely and
# exclusively on LMI's Stellaris Family of microcontroller products.
#
# The software is owned by LMI and/or its suppliers, and is protected under
# applicable copyright laws.  All rights are reserved.  Any use in violation
# of the foregoing restrictions may subject the user to criminal sanctions
# under applicable laws, as well as to civil liability for the breach of the
# terms and conditions of this license.
#
# THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
# OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
# LMI SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
# CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
#
#******************************************************************************

RTOS_SOURCE_DIR=./src

LIBRARY_PATHS += .
LIBRARY_PATHS += ./include
LIBRARY_PATHS += ${RTOS_SOURCE_DIR}/portable/GCC/NRF51_SD 

SOURCE_PATHS += ${RTOS_SOURCE_DIR}
SOURCE_PATHS += ${RTOS_SOURCE_DIR}/portable/MemMang
SOURCE_PATHS += ${RTOS_SOURCE_DIR}/portable/GCC/NRF51_SD

# List all source files the application uses.
APPLICATION_SRCS = $(notdir $(wildcard ./*.c))
APPLICATION_SRCS += app_timer.c
APPLICATION_SRCS += softdevice_handler.c

#FreeRTOS Sources
APPLICATION_SRCS += list.c
APPLICATION_SRCS += queue.c
APPLICATION_SRCS += tasks.c
APPLICATION_SRCS += port.c
APPLICATION_SRCS += heap_1.c
APPLICATION_SRCS += timers.c

PROJECT_NAME = FreeRTOS-Demo

DEVICE = NRF51

USE_SOFTDEVICE = s120

SDK_PATH = $(HOME)/devel/nrf-sdk-6.0.0/nrf51822/
TEMPLATE_PATH = ./template/

CFLAGS = -Os -g

GDB_PORT_NUMBER = 2331

include $(TEMPLATE_PATH)Makefile
