#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

VENDOR=motorola
DEVICE=triumph

mkdir -p ../../../vendor/$VENDOR/$DEVICE/proprietary

# Radio binaries
adb pull /system/bin/qmuxd  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/hci_qcomm_init  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/hciattach  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/rmt_storage  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/netmgrd  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/wpdiagd  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/port-bridge  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/btwlancoex  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/rild  ../../../vendor/$VENDOR/$DEVICE/proprietary

# Sensor binaries
adb pull /system/bin/thermald  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/geomagneticd  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/orientationd  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/proximityd  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/lightd  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/hdmid  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/bluetoothd  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/cnd  ../../../vendor/$VENDOR/$DEVICE/proprietary

# MM
adb pull /system/bin/mm-abl-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adec-omxaac-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adec-omxadpcm-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adec-omxamr-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adec-omxamrwb-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adec-omxevrc-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adec-omxmp3-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adec-omxQcelp13-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adec-omxwma-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-adspsvc-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-aenc-omxaac-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-aenc-omxamr-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-aenc-omxevrc-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-aenc-omxqcelp13-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-audio-alsa-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-audio-ctrl-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-audio-mvs-test-int  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-audio-mvs-test-ext  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-audio-native-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-audio-voem_if-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-jpeg-dec-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-jpeg-enc-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-omx-devmgr  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-qcamera-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-qcamera-testsuite-client  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-vdec-omx-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-venc-omx-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-venc-omx-test720p  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-video-driver-test  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/bin/mm-video-encdrv-test  ../../../vendor/$VENDOR/$DEVICE/proprietary

# Camera
adb pull /system/lib/libcamera.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/liboemcamera.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libmmjpeg.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libmmipl.so  ../../../vendor/$VENDOR/$DEVICE/proprietary

# Audio
adb pull /system/lib/libaudio.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libaudioalsa.so  ../../../vendor/$VENDOR/$DEVICE/proprietary

# EGL
adb pull /system/lib/egl/libEGL_adreno200.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/egl/libGLESv1_CM_adreno200.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/egl/libGLESv2_adreno200.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/egl/libq3dtools_adreno200.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libgsl.so  ../../../vendor/$VENDOR/$DEVICE/proprietary

# Sensors
adb pull /system/lib/hw/sensors.triumph.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/hw/gralloc.msm7k.so  ../../../vendor/$VENDOR/$DEVICE/proprietary

# OMX
adb pull /system/lib/libOmxEvrcEnc.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxAacDec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxQcelp13Dec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxAmrEnc.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxAdpcmDec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxEvrcDec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxAmrDec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxAmrwbDec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxWmaDec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxQcelp13Enc.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxMp3Dec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxAmrRtpDec.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxAacEnc.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libmm-adspsvc.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libomx_aacdec_sharedlibrary.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libomx_amrdec_sharedlibrary.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libomx_amrenc_sharedlibrary.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libomx_avcdec_sharedlibrary.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libomx_m4vdec_sharedlibrary.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libomx_mp3dec_sharedlibrary.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libomx_sharedlibrary.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libOmxCore.so  ../../../vendor/$VENDOR/$DEVICE/proprietary

# RIL
adb pull /system/lib/libril.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libril-qc-1.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libreference-ril.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libril-qcril-hook-oem.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libril-qc-1.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libril-qc-qmi-1.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libdiag.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/liboncrpc.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libqmi.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libqmiservices.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libdsm.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libqueue.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libdll.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libcm.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libmmgsdilib.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libgsdi_exp.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libgstk_exp.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libwms.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libnv.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libwmsts.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libpbmlib.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libdss.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libauth.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libqdp.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libidl.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libdsutils.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/liboem_rapi.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libdsi_netctrl.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libnetmgr.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/liboncrpc.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libpdapi.so ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libpdsm_atl.so  ../../../vendor/$VENDOR/$DEVICE/proprietary
adb pull /system/lib/libuim.so  ../../../vendor/$VENDOR/$DEVICE/proprietary

adb pull /system/lib/libgemini.so  ../../../vendor/$VENDOR/$DEVICE/proprietary

# GPS
adb pull /system/lib/libcommondefs.so  ../../../vendor/$VENDOR/$DEVICE/proprietary

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__VENDOR__/$VENDOR/g > ../../../vendor/$VENDOR/$DEVICE/$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/__VENDOR__/__DEVICE__/extract-files.sh

# HW init
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/qmuxd:/system/bin/qmuxd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/hci_qcomm_init:/system/bin/hci_qcomm_init

# Sensors binaries
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/geomagneticd:/system/bin/geomagneticd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/orientationd:/system/bin/orientationd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/proximityd:/system/bin/proximityd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/lightd:/system/bin/lightd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/thermald:/system/bin/thermald

# other binaries
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/hciattach:/system/bin/hciattach \\
    vendor/__VENDOR__/__DEVICE__/proprietary/netmgrd:/system/bin/netmgrd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/rmt_storage:/system/bin/rmt_storage \\
    vendor/__VENDOR__/__DEVICE__/proprietary/bluetoothd:/system/bin/bluetoothd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/port-bridge:/system/bin/port-bridge \\
    vendor/__VENDOR__/__DEVICE__/proprietary/wpdiagd:/system/bin/wpdiagd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/btwlancoex:/system/bin/btwlancoex \\
    vendor/__VENDOR__/__DEVICE__/proprietary/hdmid:/system/bin/hdmid \\
    vendor/__VENDOR__/__DEVICE__/proprietary/cnd:/system/bin/cnd

# MM
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-abl-test:/system/bin/mm-abl-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adec-omxaac-test:/system/bin/mm-adec-omxaac-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adec-omxadpcm-test:/system/bin/mm-adec-omxadpcm-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adec-omxamr-test:/system/bin/mm-adec-omxamr-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adec-omxamrwb-test:/system/bin/mm-adec-omxamrwb-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adec-omxevrc-test:/system/bin/mm-adec-omxevrc-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adec-omxmp3-test:/system/bin/mm-adec-omxmp3-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adec-omxQcelp13-test:/system/bin/mm-adec-omxQcelp13-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adec-omxwma-test:/system/bin/mm-adec-omxwma-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-adspsvc-test:/system/bin/mm-adspsvc-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-aenc-omxaac-test:/system/bin/mm-aenc-omxaac-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-aenc-omxamr-test:/system/bin/mm-aenc-omxamr-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-aenc-omxevrc-test:/system/bin/mm-aenc-omxevrc-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-aenc-omxqcelp13-test:/system/bin/mm-aenc-omxqcelp13-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-audio-alsa-test:/system/bin/mm-audio-alsa-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-audio-ctrl-test:/system/bin/mm-audio-ctrl-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-audio-mvs-test-int:/system/bin/mm-audio-mvs-test-int \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-audio-mvs-test-ext:/system/bin/mm-audio-mvs-test-ext \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-audio-native-test:/system/bin/mm-audio-native-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-audio-voem_if-test:/system/bin/mm-audio-voem_if-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-jpeg-dec-test:/system/bin/mm-jpeg-dec-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-jpeg-enc-test:/system/bin/mm-jpeg-enc-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-omx-devmgr:/system/bin/mm-omx-devmgr \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-qcamera-test:/system/bin/mm-qcamera-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-qcamera-testsuite-client:/system/bin/mm-qcamera-testsuite-client \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-vdec-omx-test:/system/bin/mm-vdec-omx-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-venc-omx-test:/system/bin/mm-venc-omx-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-venc-omx-test720p:/system/bin/mm-venc-omx-test720p \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-video-driver-test:/system/bin/mm-video-driver-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-video-encdrv-test:/system/bin/mm-video-encdrv-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libgemini.so:/system/lib/libgemini.so

# egl
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libEGL_adreno200.so:/system/lib/egl/libEGL_adreno200.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libGLESv1_CM_adreno200.so:/system/lib/egl/libGLESv1_CM_adreno200.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libGLESv2_adreno200.so:/system/lib/egl/libGLESv2_adreno200.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libq3dtools_adreno200.so:/system/lib/egl/libq3dtools_adreno200.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libgsl.so:/system/lib/libgsl.so

# Audio
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libaudio.so:/obj/lib/libaudio.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libaudio.so:/system/lib/libaudio.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libaudioalsa.so:/obj/lib/libaudioalsa.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libaudioalsa.so:/system/lib/libaudioalsa.so

# GPS
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libcommondefs.so:/obj/lib/libcommondefs.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libcommondefs.so:/system/lib/libcommondefs.so

# OMX
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxEvrcEnc.so:/system/lib/libOmxEvrcEnc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAacDec.so:/system/lib/libOmxAacDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxQcelp13Dec.so:/system/lib/libOmxQcelp13Dec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAmrEnc.so:/system/lib/libOmxAmrEnc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAdpcmDec.so:/system/lib/libOmxAdpcmDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxEvrcDec.so:/system/lib/libOmxEvrcDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAmrDec.so:/system/lib/libOmxAmrDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAmrwbDec.so:/system/lib/libOmxAmrwbDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxWmaDec.so:/system/lib/libOmxWmaDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxQcelp13Enc.so:/system/lib/libOmxQcelp13Enc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxMp3Dec.so:/system/lib/libOmxMp3Dec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAmrRtpDec.so:/system/lib/libOmxAmrRtpDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAacEnc.so:/system/lib/libOmxAacEnc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libmm-adspsvc.so:/system/lib/libmm-adspsvc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libomx_aacdec_sharedlibrary.so:/system/lib/libomx_aacdec_sharedlibrary.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libomx_amrdec_sharedlibrary.so:/system/lib/libomx_amrdec_sharedlibrary.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libomx_amrenc_sharedlibrary.so:/system/lib/libomx_amrenc_sharedlibrary.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libomx_avcdec_sharedlibrary.so:/system/lib/libomx_avcdec_sharedlibrary.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libomx_m4vdec_sharedlibrary.so:/system/lib/libomx_m4vdec_sharedlibrary.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libomx_mp3dec_sharedlibrary.so:/system/lib/libomx_mp3dec_sharedlibrary.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libomx_sharedlibrary.so:/system/lib/libomx_sharedlibrary.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxCore.so:/system/lib/libOmxCore.so

# RIL
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/rild:/system/bin/rild \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libril.so:/system/lib/libril.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libril-qc-1.so:/system/lib/libril-qc-1.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libreference-ril.so:/system/lib/libreference-ril.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libril-qcril-hook-oem.so:/system/lib/libril-qcril-hook-oem.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdiag.so:/system/lib/libdiag.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/liboncrpc.so:/system/lib/liboncrpc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libqmi.so:/system/lib/libqmi.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdsm.so:/system/lib/libdsm.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libqueue.so:/system/lib/libqueue.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdll.so:/system/lib/libdll.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libcm.so:/system/lib/libcm.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libmmgsdilib.so:/system/lib/libmmgsdilib.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libgsdi_exp.so:/system/lib/libgsdi_exp.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libgstk_exp.so:/system/lib/libgstk_exp.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libwms.so:/system/lib/libwms.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libnv.so:/system/lib/libnv.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libwmsts.so:/system/lib/libwmsts.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libpbmlib.so:/system/lib/libpbmlib.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdss.so:/system/lib/libdss.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libauth.so:/system/lib/libauth.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libril-qc-qmi-1.so:/system/lib/libril-qc-qmi-1.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libqmiservices.so:/system/lib/libqmiservices.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libqdp.so:/system/lib/libqdp.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libidl.so:/system/lib/libidl.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdsutils.so:/system/lib/libdsutils.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/liboem_rapi.so:/system/lib/liboem_rapi.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdsi_netctrl.so:/system/lib/libdsi_netctrl.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libnetmgr.so:/system/lib/libnetmgr.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libpdapi.so:/system/lib/libpdapi.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libpdsm_atl.so:/system/lib/libpdsm_atl.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libuim.so:/system/lib/libuim.so
EOF

./setup-makefiles.sh
