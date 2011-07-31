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
bin/qmuxd
bin/hci_qcomm_init

bin/geomagneticd
bin/orientationd
bin/proximityd
bin/lightd

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

lib/libOmxEvrcEnc.so
lib/libOmxAacDec.so
lib/libOmxQcelp13Dec.so
lib/libOmxAmrEnc.so
lib/libOmxAdpcmDec.so
lib/libOmxEvrcDec.so
lib/libOmxAmrDec.so
lib/libOmxAmrwbDec.so
lib/libOmxWmaDec.so
lib/libOmxQcelp13Enc.so
lib/libOmxMp3Dec.so
lib/libOmxAmrRtpDec.so
lib/libOmxAacEnc.so
lib/libmm-adspsvc.so
lib/libomx_aacdec_sharedlibrary.so
lib/libomx_amrdec_sharedlibrary.so
lib/libomx_amrenc_sharedlibrary.so
lib/libomx_avcdec_sharedlibrary.so
lib/libomx_m4vdec_sharedlibrary.so
lib/libomx_mp3dec_sharedlibrary.so
lib/libomx_sharedlibrary.so
lib/libOmxCore.so

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

 
