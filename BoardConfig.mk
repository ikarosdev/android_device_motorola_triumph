USE_CAMERA_STUB := true

# inherit from the proprietary version
-include vendor/motorola/triumph/BoardConfigVendor.mk

TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := msm7x30
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_BOOTLOADER_BOARD_NAME := triumph

BOARD_KERNEL_CMDLINE := console=ttyMSM1 androidboot.hardware=qcom
BOARD_KERNEL_BASE := 0x00200000
BOARD_PAGE_SIZE := 4096

# fix this up by examining /proc/mtd on a running device
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00380000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00480000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x08c60000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x105c0000
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_PREBUILT_KERNEL := device/motorola/triumph/kernel

# Filesystem
BOARD_DATA_DEVICE := /dev/block/mmcblk0p8
BOARD_DATA_FILESYSTEM := ext3
BOARD_CACHE_DEVICE := /dev/block/mmcblk0p11
BOARD_CACHE_FILESYSTEM := ext3
#BOARD_SDCARD_DEVICE_PRIMARY := /dev/block/mmcblk1p1
BOARD_SYSTEM_FILESYSTEM := ext3
BOARD_SYSTEM_DEVICE := /dev/block/mmcblk0p7
#BOARD_HAS_NO_MISC_PARTITION := true

# Recovery
BOARD_USES_MMCUTILS := true
BOARD_CUSTOM_RECOVERY_KEYMAPPING:= ../../device/motorola/triumph/recovery/recovery_ui.c

#BOARD_HAS_NO_SELECT_BUTTON := true
# Use this flag if the board has a ext4 partition larger than 2gb
#BOARD_HAS_LARGE_FILESYSTEM := true