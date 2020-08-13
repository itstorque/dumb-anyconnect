TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = dumbanyconnect

dumbanyconnect_FILES = Tweak.xm Library/*.m
dumbanyconnect_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 'AnyConnect'"
