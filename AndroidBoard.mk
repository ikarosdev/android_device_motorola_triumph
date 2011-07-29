LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ALL_PREBUILT += $(INSTALLED_KERNEL_TARGET)

file := $(TARGET_RECOVERY_ROOT_OUT)/default.prop
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/recovery/default.prop | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_RECOVERY_ROOT_OUT)/sbin/fih_imgupd
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/recovery/sbin/fih_imgupd | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_RECOVERY_ROOT_OUT)/system/etc/dfi/FIH_FB0.dfi
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/recovery/system/etc/dfi/FIH_FB0.dfi | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_RECOVERY_ROOT_OUT)/system/etc/dfi/FIH_SF5.dfi
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/recovery/system/etc/dfi/FIH_SF5.dfi | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_RECOVERY_ROOT_OUT)/system/etc/dfi/FIH_SF6.dfi
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/recovery/system/etc/dfi/FIH_SF6.dfi | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_RECOVERY_ROOT_OUT)/system/etc/dfi/FIH_SF8.dfi
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/recovery/system/etc/dfi/FIH_SF8.dfi | $(ACP)
	$(transform-prebuilt-to-target)

# include the non-open-source counterpart to this file
-include vendor/motorola/triumph/AndroidBoardVendor.mk
