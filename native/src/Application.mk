APP_BUILD_SCRIPT := src/Android.mk
APP_ABI          := armeabi-v7a arm64-v8a x86 x86_64 riscv64
APP_CFLAGS       := -Wall -Oz -fomit-frame-pointer
APP_CPPFLAGS     := -std=c++23
APP_STL          := none
APP_PLATFORM     := android-23
APP_THIN_ARCHIVE := true
APP_STRIP_MODE   := none
APP_SUPPORT_FLEXIBLE_PAGE_SIZES := true

ifdef MAGISK_DEBUG

NDK_APP_OUT 	 := ./obj/debug
APP_CFLAGS       += -flto=thin -gdwarf-4
APP_LDFLAGS      += -flto=thin

else

NDK_APP_OUT 	 := ./obj/release
APP_CFLAGS       += -flto
APP_LDFLAGS      += -flto -Wl,--icf=all

endif

ifdef B_CRT0

# Disable all security and debugging features
APP_CFLAGS       +=	-fno-unwind-tables -fno-asynchronous-unwind-tables -fno-stack-protector -U_FORTIFY_SOURCE
# Override output folder to make sure all dependencies are rebuilt with new CFLAGS
NDK_APP_OUT      := $(NDK_APP_OUT)-nolibc

endif
