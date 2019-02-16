#
# Copyright (c) 2015-2018, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

SOC_DIR			:=	plat/nvidia/tegra/soc/${TARGET_SOC}

# dump the state on crash console
CRASH_REPORTING		:=	1
$(eval $(call add_define,CRASH_REPORTING))

# enable assert() for release/debug builds
ENABLE_ASSERTIONS	:=	1
PLAT_LOG_LEVEL_ASSERT	:=	40
$(eval $(call add_define,PLAT_LOG_LEVEL_ASSERT))

# enable dynamic memory mapping
PLAT_XLAT_TABLES_DYNAMIC :=	1
$(eval $(call add_define,PLAT_XLAT_TABLES_DYNAMIC))

# Enable PSCI v1.0 extended state ID format
PSCI_EXTENDED_STATE_ID	:=	1

# code and read-only data should be put on separate memory pages
SEPARATE_CODE_AND_RODATA :=	1

# do not use coherent memory
USE_COHERENT_MEM	:=	0

# do not enable SVE
ENABLE_SVE_FOR_NS	:=	0

# enable D-cache early during CPU warmboot
WARMBOOT_ENABLE_DCACHE_EARLY := 1

# remove the standard libc
OVERRIDE_LIBC		:=	1

include plat/nvidia/tegra/common/tegra_common.mk
include ${SOC_DIR}/platform_${TARGET_SOC}.mk

# modify BUILD_PLAT to point to SoC specific build directory
BUILD_PLAT	:=	${BUILD_BASE}/${PLAT}/${TARGET_SOC}/${BUILD_TYPE}

# platform cflags (enable signed comparisons, disable stdlib)
TF_CFLAGS	+= -Wsign-compare -nostdlib

# override with necessary libc files for the Tegra platform
override LIBC_SRCS :=	$(addprefix lib/libc/,		\
			assert.c			\
			memcpy.c			\
			memmove.c			\
			memset.c			\
			printf.c			\
			putchar.c			\
			strlen.c			\
			snprintf.c)

INCLUDES	+=	-Iinclude/lib/libc		\
			-Iinclude/lib/libc/$(ARCH)	\
