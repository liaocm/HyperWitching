INSTALL_TARGET_PROCESSES = madomagi

export SDKVERSION = 13.0

# Local installation path
THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2221

ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HyperWitching

HyperWitching_FILES = Tweak.xm MHWDriver.m
HyperWitching_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
