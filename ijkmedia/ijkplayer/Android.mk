#
# Copyright (c) 2013 Zhang Rui <bbcallen@gmail.com>
#
# This file is part of ijkPlayer.
#
# ijkPlayer is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# ijkPlayer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with ijkPlayer; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA




LOCAL_PATH := $(call my-dir)

#include $(CLEAR_VARS)
#LOCAL_MODULE := speex-prebuilt
#LOCAL_SRC_FILES := libspeex.so
#include $(PREBUILT_SHARED_LIBRARY)

APP_ALLOW_MISSING_DEPS=true


LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
# -mfloat-abi=soft is a workaround for FP register corruption on Exynos 4210
# http://www.spinics.net/lists/arm-kernel/msg368417.html
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -mfloat-abi=soft
endif
LOCAL_CFLAGS += -std=c99
#armv7 descomentar para compilar la libreria con speex para v7
#LOCAL_LDLIBS += -llog -landroid -lm -lz -L/home/angel/tmp/ttt/obj/local/armeabi-v7a/  -lspeex
#amrv64 descomentar para compilar la libreria con speex para arm64
LOCAL_LDLIBS += -llog -landroid -lm -lz -L/home/angel/tmp/ttt/obj/local/arm64-v8a/ -lspeex
#original
#LOCAL_LDLIBS += -llog -landroid -lm -lz 


LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(realpath $(LOCAL_PATH)/..)
LOCAL_C_INCLUDES += $(MY_APP_FFMPEG_INCLUDE_PATH)

LOCAL_SRC_FILES += ff_cmdutils.c
LOCAL_SRC_FILES += ff_ffplay.c
LOCAL_SRC_FILES += ff_ffpipeline.c
LOCAL_SRC_FILES += ff_ffpipenode.c	
LOCAL_SRC_FILES += ijkmeta.c
LOCAL_SRC_FILES += ijkplayer.c

LOCAL_SRC_FILES += pipeline/ffpipeline_ffplay.c
LOCAL_SRC_FILES += pipeline/ffpipenode_ffplay_vdec.c
LOCAL_SRC_FILES += pipeline/ffpipenode_ffplay_vout.c

LOCAL_SRC_FILES += android/ffmpeg_api_jni.c
LOCAL_SRC_FILES += android/ijkplayer_android.c
LOCAL_SRC_FILES += android/ijkplayer_jni.c

LOCAL_SRC_FILES += android/pipeline/ffpipeline_android.c
LOCAL_SRC_FILES += android/pipeline/ffpipenode_android_mediacodec_vdec.c
LOCAL_SRC_FILES += android/pipeline/ffpipenode_android_mediacodec_vout.c
LOCAL_STATIC_LIBRARIES := ijksdl ijkutil 
LOCAL_STATIC_LIBRARIES += libspeex libavformat libavcodec libswresample libswscale libavutil
#LOCAL_SHARED_LIBRARIES := speex-prebuilt

LOCAL_MODULE := pldroidplayer
include $(BUILD_SHARED_LIBRARY)
