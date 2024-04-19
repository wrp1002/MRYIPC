GO_EASY_ON_ME = 1

PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	ARCHS = arm64 arm64e
	TARGET = iphone:clang:15.5:15.0
else
	ARCHS = armv7 arm64 arm64e
	TARGET = iphone:clang:14.2:8.0
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libmryipc
libmryipc_FILES = MRYIPCCenter.m mrybootstrap.m
libmryipc_CFLAGS = -fobjc-arc -IInclude
ADDITIONAL_CFLAGS = -DTHEOS_LEAN_AND_MEAN

include $(THEOS_MAKE_PATH)/library.mk

internal-stage::
	mkdir -p usr/lib
	cp $(THEOS_STAGING_DIR)/usr/lib/libmryipc.dylib usr/lib/libmryipc.dylib

SUBPROJECTS += mrybootstrap
include $(THEOS_MAKE_PATH)/aggregate.mk
