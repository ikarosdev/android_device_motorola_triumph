$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/motorola/triumph/triumph-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/motorola/triumph/overlay

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/motorola/triumph/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    MagicSmokeWallpapers \
    VisualizationWallpapers \
    Gallery3d \
    SpareParts \
    Term \
    librs_jni \
    gps.triumph \
    gralloc.msm7x30 \
    lights.msm7x30 \
    overlay.default \
    libOmxCore \
    libOmxVenc \
    libOmxVdec

# Init files
PRODUCT_COPY_FILES += \
    device/motorola/triumph/init.triumph.rc:root/init.triumph.rc \
    device/motorola/triumph/ueventd.qcom.rc:root/ueventd.qcom.rc

# vold
PRODUCT_COPY_FILES += \
    device/motorola/triumph/vold.fstab:system/etc/vold.fstab

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:/system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:/system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:/system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.camera.xml:/system/etc/permissions/android.hardware.camera.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:/system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:/system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:/system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:/system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:/system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:/system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:/system/etc/permissions/android.hardware.touchscreen.multitouch.xml
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

# init scripts
PRODUCT_COPY_FILES += \
    device/motorola/triumph/include/etc/init.qcom.bt.sh:/system/etc/init.qcom.bt.sh \
    device/motorola/triumph/include/etc/init.qcom.coex.sh:/system/etc/init.qcom.coex.sh\
    device/motorola/triumph/include/etc/init.qcom.bt.sh:/system/etc/init.qcom.fm.sh \
    device/motorola/triumph/include/etc/init.qcom.sdio.sf6.sh:/system/etc/init.qcom.sdio.sf6.sh \
    device/motorola/triumph/include/etc/init.qcom.sdio.sh:/system/etc/init.qcom.sdio.sh \
    device/motorola/triumph/include/etc/init.qcom.wifi.sh:/system/etc/init.qcom.wifi.sh

# HW init
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/bin/qmuxd:/system/bin/qmuxd \
    vendor/motorola/triumph/proprietary/bin/hci_qcomm_init:/system/bin/hci_qcomm_init

# Sensors binaries
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/bin/geomagneticd:/system/bin/geomagneticd \
    vendor/motorola/triumph/proprietary/bin/orientationd:/system/bin/orientationd \
    vendor/motorola/triumph/proprietary/bin/proximityd:/system/bin/proximityd \
    vendor/motorola/triumph/proprietary/bin/lightd:/system/bin/lightd

# HDMI binary
    vendor/motorola/triumph/proprietary/bin/hdmid:/system/bin/hdmid

# MM binaries
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/bin/mm-abl-test:/system/bin/mm-abl-test \
    vendor/motorola/triumph/proprietary/bin/mm-adec-omxaac-test:/system/bin/mm-adec-omxaac-test \
    vendor/motorola/triumph/proprietary/bin/mm-adec-omxadpcm-test:/system/bin/mm-adec-omxadpcm-test \
    vendor/motorola/triumph/proprietary/bin/mm-adec-omxamr-test:/system/bin/mm-adec-omxamr-test \
    vendor/motorola/triumph/proprietary/bin/mm-adec-omxamrwb-test:/system/bin/mm-adec-omxamrwb-test \
    vendor/motorola/triumph/proprietary/bin/mm-adec-omxevrc-test:/system/bin/mm-adec-omxevrc-test \
    vendor/motorola/triumph/proprietary/bin/mm-adec-omxmp3-test:/system/bin/mm-adec-omxmp3-test \
    vendor/motorola/triumph/proprietary/bin/mm-adec-omxQcelp13-test:/system/bin/mm-adec-omxQcelp13-test \
    vendor/motorola/triumph/proprietary/bin/mm-adec-omxwma-test:/system/bin/mm-adec-omxwma-test \
    vendor/motorola/triumph/proprietary/bin/mm-adspsvc-test:/system/bin/mm-adspsvc-test \
    vendor/motorola/triumph/proprietary/bin/mm-aenc-omxaac-test:/system/bin/mm-aenc-omxaac-test \
    vendor/motorola/triumph/proprietary/bin/mm-aenc-omxamr-test:/system/bin/mm-aenc-omxamr-test \
    vendor/motorola/triumph/proprietary/bin/mm-aenc-omxevrc-test:/system/bin/mm-aenc-omxevrc-test \
    vendor/motorola/triumph/proprietary/bin/mm-aenc-omxqcelp13-test:/system/bin/mm-aenc-omxqcelp13-test \
    vendor/motorola/triumph/proprietary/bin/mm-audio-alsa-test:/system/bin/mm-audio-alsa-test \
    vendor/motorola/triumph/proprietary/bin/mm-audio-ctrl-test:/system/bin/mm-audio-ctrl-test \
    vendor/motorola/triumph/proprietary/bin/mm-audio-mvs-test-int:/system/bin/mm-audio-mvs-test-int \
    vendor/motorola/triumph/proprietary/bin/mm-audio-mvs-test-ext:/system/bin/mm-audio-mvs-test-ext \
    vendor/motorola/triumph/proprietary/bin/mm-audio-native-test:/system/bin/mm-audio-native-test \
    vendor/motorola/triumph/proprietary/bin/mm-audio-voem_if-test:/system/bin/mm-audio-voem_if-test \
    vendor/motorola/triumph/proprietary/bin/mm-jpeg-dec-test:/system/bin/mm-jpeg-dec-test \
    vendor/motorola/triumph/proprietary/bin/mm-jpeg-enc-test:/system/bin/mm-jpeg-enc-test \
    vendor/motorola/triumph/proprietary/bin/mm-omx-devmgr:/system/bin/mm-omx-devmgr \
    vendor/motorola/triumph/proprietary/bin/mm-qcamera-test:/system/bin/mm-qcamera-test \
    vendor/motorola/triumph/proprietary/bin/mm-qcamera-testsuite-client:/system/bin/mm-qcamera-testsuite-client \
    vendor/motorola/triumph/proprietary/bin/mm-vdec-omx-test:/system/bin/mm-vdec-omx-test \
    vendor/motorola/triumph/proprietary/bin/mm-venc-omx-test:/system/bin/mm-venc-omx-test \
    vendor/motorola/triumph/proprietary/bin/mm-venc-omx-test720p:/system/bin/mm-venc-omx-test720p \
    vendor/motorola/triumph/proprietary/bin/mm-video-driver-test:/system/bin/mm-video-driver-test \
    vendor/motorola/triumph/proprietary/bin/mm-video-encdrv-test:/system/bin/mm-video-encdrv-test

# egl
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/lib/egl/libEGL_adreno200.so:/system/lib/egl/libEGL_adreno200.so \
    vendor/motorola/triumph/proprietary/lib/egl/libGLESv1_CM_adreno200.so:/system/lib/egl/libGLESv1_CM_adreno200.so \
    vendor/motorola/triumph/proprietary/lib/egl/libGLESv2_adreno200.so:/system/lib/egl/libGLESv2_adreno200.so \
    vendor/motorola/triumph/proprietary/lib/egl/libq3dtools_adreno200.so:/system/lib/egl/libq3dtools_adreno200.so \
    vendor/motorola/triumph/proprietary/lib/libgsl.so:/system/lib/libgsl.so

# Video firmware
PRODUCT_COPY_FILES += \
    device/motorola/triumph/include/etc/firmware/vidc_720p_command_control.fw:/system/etc/firmware/vidc_720p_command_control.fw \
    device/motorola/triumph/include/etc/firmware/vidc_720p_h263_dec_mc.fw:/system/etc/firmware/vidc_720p_h263_dec_mc.fw \
    device/motorola/triumph/include/etc/firmware/vidc_720p_h264_dec_mc.fw:/system/etc/firmware/vidc_720p_h264_dec_mc.fw \
    device/motorola/triumph/include/etc/firmware/vidc_720p_h264_enc_mc.fw:/system/etc/firmware/vidc_720p_h264_enc_mc.fw \
    device/motorola/triumph/include/etc/firmware/vidc_720p_mp4_dec_mc.fw:/system/etc/firmware/vidc_720p_mp4_dec_mc.fw \
    device/motorola/triumph/include/etc/firmware/vidc_720p_mp4_enc_mc.fw:/system/etc/firmware/vidc_720p_mp4_enc_mc.fw \
    device/motorola/triumph/include/etc/firmware/vidc_720p_vc1_dec_mc.fw:/system/etc/firmware/vidc_720p_vc1_dec_mc.fw \
    device/motorola/triumph/include/etc/firmware/yamato_pfp.fw:/system/etc/firmware/yamato_pfp.fw \
    device/motorola/triumph/include/etc/firmware/yamato_pm4.fw:/system/etc/firmware/yamato_pm4.fw

# Camera
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/lib/libcamera.so:/system/lib/libcamera.so \
    vendor/motorola/triumph/proprietary/lib/libcamera.so:/obj/lib/libcamera.so \
    vendor/motorola/triumph/proprietary/lib/liboemcamera.so:/system/lib/liboemcamera.so \
    vendor/motorola/triumph/proprietary/lib/libmmjpeg.so:/system/lib/libmmjpeg.so \
    vendor/motorola/triumph/proprietary/lib/libmmipl.so:/system/lib/libmmipl.so

# Audio
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/lib/libaudio.so:/obj/lib/libaudio.so \
    vendor/motorola/triumph/proprietary/lib/libaudio.so:/system/lib/libaudio.so \
    vendor/motorola/triumph/proprietary/lib/libaudioalsa.so:/obj/lib/libaudioalsa.so \
    vendor/motorola/triumph/proprietary/lib/libaudioalsa.so:/system/lib/libaudioalsa.so \
    vendor/motorola/triumph/proprietary/lib/libaudioeq.so:/system/lib/libaudioeq.so

# Sensors
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/lib/hw/sensors.qcom.so:/system/lib/hw/sensors.qcom.so

# Wifi
PRODUCT_COPY_FILES += \
    device/motorola/triumph/modules/wifi/libra.ko:/system/wifi/libra.ko \
    device/motorola/triumph/modules/wifi/librasdioif.ko:/system/wifi/librasdioif.ko \
    device/motorola/triumph/include/etc/firmware/wlan/qcom_fw.bin:/system/etc/firmware/wlan/qcom_fw.bin \
    device/motorola/triumph/include/etc/firmware/wlan/qcom_wapi_fw.bin:/system/etc/firmware/wlan/qcom_wapi_fw.bin \
    device/motorola/triumph/include/etc/firmware/wlan/qcom_wlan_nv.bin:/system/etc/firmware/wlan/qcom_wlan_nv.bin \
    device/motorola/triumph/include/etc/firmware/wlan/cfg.dat:/system/etc/firmware/wlan/cfg.dat \
    device/motorola/triumph/include/etc/hostapd/hostapd.conf:/system/etc/hostapd/hostapd.conf \
    device/motorola/triumph/include/etc/firmware/wlan/qcom_cfg.ini:/system/etc/firmware/wlan/qcom_cfg.ini \
    device/motorola/triumph/include/etc/wifi/wpa_supplicant.conf:/system/etc/wifi/wpa_supplicant.conf

# OMX
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/lib/libOmxEvrcEnc.so:/system/lib/libOmxEvrcEnc.so \
    vendor/motorola/triumph/proprietary/lib/libOmxAacDec.so:/system/lib/libOmxAacDec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxQcelpDec.so:/system/lib/libOmxQcelp13Dec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxAmrEnc.so:/system/lib/libOmxAmrEnc.so \
    vendor/motorola/triumph/proprietary/lib/libOmxAdpcmDec.so:/system/lib/libOmxAdpcmDec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxEvrcDec.so:/system/lib/libOmxEvrcDec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxAmrDec.so:/system/lib/libOmxAmrDec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxAmrwbDec.so:/system/lib/libOmxAmrwbDec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxWmaDec.so:/system/lib/libOmxWmaDec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxQcelp13Enc.so:/system/lib/libOmxQcelp13Enc.so \
    vendor/motorola/triumph/proprietary/lib/libOmxMp3Dec.so:/system/lib/libOmxMp3Dec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxAmrRtpDec.so:/system/lib/libOmxAmrRtpDec.so \
    vendor/motorola/triumph/proprietary/lib/libOmxAacEnc.so:/system/lib/libOmxAacEnc.so \
    vendor/motorola/triumph/proprietary/lib/libmm-adspsvc.so:/system/lib/libmm-adspsvc.so \
    vendor/motorola/triumph/proprietary/lib/libomx_aacdec_sharedlibrary.so:/system/lib/libomx_aacdec_sharedlibrary.so \
    vendor/motorola/triumph/proprietary/lib/libomx_amrdec_sharedlibrary.so:/system/lib/libomx_amrdec_sharedlibrary.so \
    vendor/motorola/triumph/proprietary/lib/libomx_amrenc_sharedlibrary.so:/system/lib/libomx_amrenc_sharedlibrary.so \
    vendor/motorola/triumph/proprietary/lib/libomx_avcdec_sharedlibrary.so:/system/lib/libomx_avcdec_sharedlibrary.so \
    vendor/motorola/triumph/proprietary/lib/libomx_m4vdec_sharedlibrary.so:/system/lib/libomx_m4vdec_sharedlibrary.so \
    vendor/motorola/triumph/proprietary/lib/libomx_mp3dec_sharedlibrary.so:/system/lib/libomx_mp3dec_sharedlibrary.so \
    vendor/motorola/triumph/proprietary/lib/libomx_sharedlibrary.so:/system/lib/libomx_sharedlibrary.so \
    vendor/motorola/triumph/proprietary/lib/libOmxCore.so:/system/lib/libOmxCore.so

# RIL
PRODUCT_COPY_FILES += \
    vendor/motorola/triumph/proprietary/lib/libril.so:/system/lib/libril.so \
    vendor/motorola/triumph/proprietary/lib/libril-qc-1.so:/system/lib/libril-qc-1.so \
    vendor/motorola/triumph/proprietary/lib/libreference-ril.so:/system/lib/libreference-ril.so \
    vendor/motorola/triumph/proprietary/lib/libril-qcril-hook-oem.so:/system/lib/libril-qcril-hook-oem.so \
    vendor/motorola/triumph/proprietary/lib/libdiag.so:/system/lib/libdiag.so \
    vendor/motorola/triumph/proprietary/lib/liboncrpc.so:/system/lib/liboncrpc.so \
    vendor/motorola/triumph/proprietary/lib/libqmi.so:/system/lib/libqmi.so \
    vendor/motorola/triumph/proprietary/lib/libdsm.so:/system/lib/libdsm.so \
    vendor/motorola/triumph/proprietary/lib/libqueue.so:/system/lib/libqueue.so \
    vendor/motorola/triumph/proprietary/lib/libdll.so:/system/lib/libdll.so \
    vendor/motorola/triumph/proprietary/lib/libcm.so:/system/lib/libcm.so \
    vendor/motorola/triumph/proprietary/lib/libmmgsdilib.so:/system/lib/libmmgsdilib.so \
    vendor/motorola/triumph/proprietary/lib/libgsdi_exp.so:/system/lib/libgsdi_exp.so \
    vendor/motorola/triumph/proprietary/lib/libgstk_exp.so:/system/lib/libgstk_exp.so \
    vendor/motorola/triumph/proprietary/lib/libwms.so:/system/lib/libwms.so \
    vendor/motorola/triumph/proprietary/lib/libnv.so:/system/lib/libnv.so \
    vendor/motorola/triumph/proprietary/lib/libwmsts.so:/system/lib/libwmsts.so \
    vendor/motorola/triumph/proprietary/lib/libpbmlib.so:/system/lib/libpbmlib.so \
    vendor/motorola/triumph/proprietary/lib/libdss.so:/system/lib/libdss.so \
    vendor/motorola/triumph/proprietary/lib/libauth.so:/system/lib/libauth.so

# xml config
PRODUCT_COPY_FILES += \
    device/motorola/triumph/include/etc/media_profiles.xml:system/etc/media_profiles.xml

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

# Perfomance tweaks
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.heapsize=48m \
    persist.sys.use_dithering=1 \
    ro.compcache.default=0

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libril-qc-1.so \
    rild.libargs=-d /dev/smd0 \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=60 \
    ro.com.android.dataroaming=false \
    ro.sf.lcd_density=240 \
    debug.sf.hw=1

# Properties taken from build.prop
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-motorola \
    ro.com.google.clientidbase.yt=android-motorola \
    ro.com.google.clientidbase.am=android-motorola \
    ro.com.google.clientidbase.ms=android-motorola \
    ro.com.google.clientidbase.gmm=android-motorola \
    ro.cdma.home.operator.alpha=Virgin Mobile \
    gsm.operator.alpha=Virgin Mobile \
    ro.telephony.gsm.ecclist=110,112,119,911 \
    ro.telephony.cdma.ecclist=110,112,119,911 \
    ro.telephony.ecclist=08,000,110,112,118,119,911,999 \
    ro.telephony.num.auto.hyphen=true \
    ro.telephony.gsm.spn.shortname=true \
    gsm.operator.iso-country=us \
    gsm.operator.numeric=311490 \
    ro.cdma.home.operator.numeric=311490 \
    keyguard.no_require_sim=true

# Triumph uses high-density artwork where available
PRODUCT_LOCALES += hdpi

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := motorola_triumph
PRODUCT_DEVICE := triumph
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := MOTWX435KT
PRODUCT_MANUFACTURER := Motorola