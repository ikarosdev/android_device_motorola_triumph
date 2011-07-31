#!/bin/sh

mkdir -p ../../../vendor/motorola/triumph/proprietary


DIRS="
bin
lib/egl
lib/hw
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/motorola/triumph/proprietary/$DIR
done

FILES="
lib/libcamera.so
lib/liboemcamera.so
lib/libmmjpeg.so
lib/libmmipl.so

lib/libaudio.so
lib/libaudioalsa.so
lib/libaudioeq.so

lib/egl/egl.cfg
lib/egl/libEGL_adreno200.so
lib/egl/libGLESv1_CM_adreno200.so
lib/egl/libGLESv2_adreno200.so
lib/egl/libq3dtools_adreno200.so

lib/hw/sensors.qcom.so

lib/libmm-adspsvc.so
lib/libOmxAacDec.so
lib/libOmxAacEnc.so
lib/libOmxAmrDec.so
lib/libOmxAmrEnc.so
lib/libOmxAmrRtpDec.so
lib/libOmxAmrwbDec.so
lib/libOmxEvrcDec.so
lib/libOmxEvrcEnc.so
lib/libOmxH264Dec.so
lib/libOmxMp3Dec.so
lib/libOmxMpeg4Dec.so
lib/libOmxQcelp13Enc.so
lib/libOmxQcelp13Dec.so
lib/libOmxVidEnc.so
lib/libOmxWmaDec.so
lib/libOmxWmvDec.so

lib/libril-qc-1.so
lib/libreference-ril.so
lib/libril-qcril-hook-oem.so
lib/libdiag.so
lib/liboncrpc.so
lib/libqmi.so
lib/libdsm.so
lib/libqueue.so
lib/libdll.so
lib/libcm.so
lib/libmmgsdilib.so
lib/libgsdi_exp.so
lib/libgstk_exp.so
lib/libwms.so
lib/libnv.so
lib/libwmsts.so
lib/libpbmlib.so
lib/libdss.so
lib/libauth.so
"

for FILE in $FILES; do
	adb pull system/$FILE ../../../vendor/motorola/triumph/proprietary/$FILE
done

 
