LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file): $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

# include the non-open-source counterpart to this file
-include vendor/motorola/triumph/AndroidBoardVendor.mk
