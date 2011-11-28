/*
 * Copyright (C) 2008 The Android Open Source Project
 * Copyright (c) 2009, Code Aurora Forum. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "Overlay"

#include <hardware/hardware.h>
#include "overlayLib.h"
#include <cutils/properties.h>
#include <utils/threads.h>

using android::Mutex;

#define USE_MSM_ROTATOR
/*****************************************************************************/

using namespace overlay;

struct overlay_control_context_t {
	struct overlay_control_device_t device;
};

struct overlay_data_context_t {
	struct overlay_data_device_t device;
	OverlayDataChannel* pobjDataChannel[2];
};

static int overlay_device_open(const struct hw_module_t* module, const char* name,
							   struct hw_device_t** device);

static struct hw_module_methods_t overlay_module_methods = {
	open: overlay_device_open
};

struct private_module_t {
        overlay_module_t base;
	Mutex *pobjMutex;
};

struct private_module_t HAL_MODULE_INFO_SYM = {
    base: {
	common: {
		tag: HARDWARE_MODULE_TAG,
		version_major: 1,
		version_minor: 0,
		id: OVERLAY_HARDWARE_MODULE_ID,
		name: "QCT MSM OVERLAY module",
		author: "QuIC, Inc.",
		methods: &overlay_module_methods,
	}
   },
   pobjMutex: NULL,
};

struct handle_t : public native_handle {
        int ovid[2];
	int rotid[2];
	int size;
	int w;
	int h;
	int format;
	OverlayControlChannel *pobjControlChannel[2];
};

static int handle_get_ovId(const overlay_handle_t overlay, int index = 0) {
	return static_cast<const struct handle_t *>(overlay)->ovid[index];
}

static int handle_get_rotId(const overlay_handle_t overlay, int index = 0) {
	return static_cast<const struct handle_t *>(overlay)->rotid[index];
}


static int handle_get_size(const overlay_handle_t overlay) {
	return static_cast<const struct handle_t *>(overlay)->size;
}

/*
 * This is the overlay_t object, it is returned to the user and represents
 * an overlay.
 * This handles will be passed across processes and possibly given to other
 * HAL modules (for instance video decode modules).
 */
class overlay_object : public overlay_t {
	handle_t mHandle;

	static overlay_handle_t getHandleRef(struct overlay_t* overlay) {
		/* returns a reference to the handle, caller doesn't take ownership */
		return &(static_cast<overlay_object *>(overlay)->mHandle);
	}

public:
	overlay_object(int w, int h, int format) {
		this->overlay_t::getHandleRef = getHandleRef;
		mHandle.version = sizeof(native_handle);
		mHandle.numFds = 0;
		mHandle.numInts = (sizeof(mHandle) - sizeof(native_handle)) / 4;
		mHandle.ovid[0] = -1;
		mHandle.ovid[1] = -1;
		mHandle.rotid[0] = -1;
		mHandle.rotid[1] = -1;
		mHandle.size = -1;
		mHandle.w = w;
		mHandle.h = h;
		mHandle.format = format;
		mHandle.pobjControlChannel[0] = 0;
		mHandle.pobjControlChannel[1] = 0;
	}

	~overlay_object() {
	    destroy_overlay();
	}

	int getHwOvId(int index = 0) { return mHandle.ovid[index]; }
        int getRotSessionId(int index = 0) { return mHandle.rotid[index]; }

	bool startControlChannel(int fbnum, bool norot = false) {
	    if (!mHandle.pobjControlChannel[fbnum])
	        mHandle.pobjControlChannel[fbnum] = new OverlayControlChannel();
	    else {
		mHandle.pobjControlChannel[fbnum]->closeControlChannel();
	        mHandle.pobjControlChannel[fbnum] = new OverlayControlChannel();
	    }
	    bool ret = mHandle.pobjControlChannel[fbnum]->startControlChannel(
	                 mHandle.w, mHandle.h, mHandle.format, fbnum, norot);
	    if (ret) {
	        if (!(mHandle.pobjControlChannel[fbnum]->
		             getOvSessionID(mHandle.ovid[fbnum]) &&
			     mHandle.pobjControlChannel[fbnum]->
			     getRotSessionID(mHandle.rotid[fbnum]) &&
			     mHandle.pobjControlChannel[fbnum]->
			     getSize(mHandle.size)))
	            ret = false;
	    }

	    if (!ret) {
	        closeControlChannel(fbnum);
	    }

	    return ret;
	}

	bool setPosition(int x, int y, uint32_t w, uint32_t h, int fbnum) {
	    if (!mHandle.pobjControlChannel[fbnum])
	        return false;
	    return mHandle.pobjControlChannel[fbnum]->setPosition(
	                     x, y, w, h);
	}

	bool setParameter(int param, int value, int fbnum) {
	    if (!mHandle.pobjControlChannel[fbnum])
	        return false;
	    return mHandle.pobjControlChannel[fbnum]->setParameter(
	                     param, value);
	}

	bool closeControlChannel(int fbnum) {
	    if (!mHandle.pobjControlChannel[fbnum])
	        return true;
	    bool ret = mHandle.pobjControlChannel[fbnum]->
	                  closeControlChannel();
	    delete mHandle.pobjControlChannel[fbnum];
	    mHandle.pobjControlChannel[fbnum] = 0;
	    return ret;
	}

	bool getPosition(int *x, int *y, uint32_t *w, uint32_t *h, int fbnum) {
	    if (!mHandle.pobjControlChannel[fbnum])
	        return false;
	    return mHandle.pobjControlChannel[fbnum]->getPosition(
	                     *x, *y, *w, *h);
	}

	bool getOrientation(int *orientation, int fbnum) {
	    if (!mHandle.pobjControlChannel[fbnum])
	        return false;
	    return mHandle.pobjControlChannel[fbnum]->getOrientation(
	                     *orientation);
	}

	void destroy_overlay() {
	    closeControlChannel(0);
	    closeControlChannel(1);
	}

	int getFBWidth(int fbnum) {
	    if (!mHandle.pobjControlChannel[fbnum])
	        return false;
	    return mHandle.pobjControlChannel[fbnum]->getFBWidth();
	}

	int getFBHeight(int fbnum) {
	    if (!mHandle.pobjControlChannel[fbnum])
	        return false;
	    return mHandle.pobjControlChannel[fbnum]->getFBHeight();
	}
};

// ****************************************************************************
// Control module
// ****************************************************************************

	static int overlay_get(struct overlay_control_device_t *dev, int name) {
		int result = -1;
		switch (name) {
			case OVERLAY_MINIFICATION_LIMIT:
				result = 8;
				break;
			case OVERLAY_MAGNIFICATION_LIMIT:
				result = 8;
				break;
			case OVERLAY_SCALING_FRAC_BITS:
				result = 32;
				break;
			case OVERLAY_ROTATION_STEP_DEG:
				result = 90; // 90 rotation steps (for instance)
				break;
			case OVERLAY_HORIZONTAL_ALIGNMENT:
				result = 1;	// 1-pixel alignment
				break;
			case OVERLAY_VERTICAL_ALIGNMENT:
				result = 1;	// 1-pixel alignment
				break;
			case OVERLAY_WIDTH_ALIGNMENT:
				result = 1;	// 1-pixel alignment
				break;
			case OVERLAY_HEIGHT_ALIGNMENT:
				result = 1;	// 1-pixel alignment
				break;
		}
		return result;
	}

	static overlay_t* overlay_createOverlay(struct overlay_control_device_t *dev,
											uint32_t w, uint32_t h, int32_t format) {
		overlay_object            *overlay = NULL;
		overlay_control_context_t *ctx = (overlay_control_context_t *)dev;
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);
		Mutex::Autolock objLock(m->pobjMutex);
		/* number of buffer is not being used as overlay buffers are coming from client */
		overlay = new overlay_object(w, h, format);

		if (overlay == NULL) {
			LOGE("%s: can't create overlay object!", __FUNCTION__);
			return NULL;
		}

#ifdef USE_MSM_ROTATOR
		if (!overlay->startControlChannel(0)) {
#else
		if (!overlay->startControlChannel(0, true)) {
#endif
			LOGE("Failed to start control channel for framebuffer 0");
			overlay->closeControlChannel(0);
			return NULL;
		}

		char value[PROPERTY_VALUE_MAX];
		property_get("hw.hdmiON", value, "0");
		if (!atoi(value)) {
                        return overlay;
		}

		if (!overlay->startControlChannel(1, true)) {
			LOGE("Failed to start control channel for framebuffer 1");
			overlay->closeControlChannel(1);
		}
		else {
			int width = w, height = h, x, y;
			int ratioW, ratioH;

			int fbWidthHDMI = overlay->getFBWidth(1);
			int fbHeightHDMI = overlay->getFBHeight(1);

			if (width * fbHeightHDMI >
					fbWidthHDMI * height) {
				height = fbWidthHDMI * height / width;
				height = (height ^ 1);
				width = fbWidthHDMI;
			} else if (width * fbHeightHDMI <
					fbWidthHDMI * height) {
				width = fbHeightHDMI * width / height;
				width = (width ^ 1);
				height = fbHeightHDMI;
			} else {
				width = fbWidthHDMI;
				height = fbHeightHDMI;
			}

			if (width > fbWidthHDMI) width = fbWidthHDMI;
			if (height > fbHeightHDMI) height = fbHeightHDMI;
			x = (fbWidthHDMI - width) / 2;
			y = (fbHeightHDMI - height) / 2;

			if (!overlay->setPosition(x, y, width, height, 1))
			    LOGE("Failed to upscale for framebuffer 1");
		}

		return overlay;

	}

	static void overlay_destroyOverlay(struct overlay_control_device_t *dev,
									   overlay_t* overlay)
	{
		overlay_object * obj = static_cast<overlay_object *>(overlay);
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);
		Mutex::Autolock objLock(m->pobjMutex);
		obj->destroy_overlay();
		delete overlay;
	}

	static int overlay_setPosition(struct overlay_control_device_t *dev,
								   overlay_t* overlay,
								   int x, int y, uint32_t w, uint32_t h) {
		/* set this overlay's position (talk to the h/w) */
		overlay_control_context_t *ctx = (overlay_control_context_t *)dev;
		overlay_object * obj = static_cast<overlay_object *>(overlay);
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);
		Mutex::Autolock objLock(m->pobjMutex);

		bool ret = obj->setPosition(x, y, w, h, 0);
		if (!ret)
		    	return -1;
		return 0;
	}

	static int overlay_commit(struct overlay_control_device_t *dev,
								   overlay_t* overlay)
	{
		return 0;
	}

	static int overlay_getPosition(struct overlay_control_device_t *dev,
								   overlay_t* overlay,
								   int* x, int* y, uint32_t* w, uint32_t* h) {

		/* get this overlay's position */
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);
		Mutex::Autolock objLock(m->pobjMutex);
		overlay_object * obj = static_cast<overlay_object *>(overlay);
		bool ret = obj->getPosition(x, y, w, h, 0);
		if (!ret)
		    return -1;
		return 0;
	}

	static int overlay_setParameter(struct overlay_control_device_t *dev,
									overlay_t* overlay, int param, int value) {

		overlay_control_context_t *ctx = (overlay_control_context_t *)dev;
		overlay_object *obj = static_cast<overlay_object *>(overlay);
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);

		Mutex::Autolock objLock(m->pobjMutex);
		bool ret = obj->setParameter(param, value, 0);
		if (!ret)
	            return -1;
                return 0;
	}

	static int overlay_control_close(struct hw_device_t *dev)
	{
		struct overlay_control_context_t* ctx = (struct overlay_control_context_t*)dev;
		if (ctx) {
			/* free all resources associated with this device here
			 * in particular the overlay_handle_t, outstanding overlay_t, etc...
			 */
			free(ctx);
		}
		return 0;
	}

// ****************************************************************************
// Data module
// ****************************************************************************

	int overlay_initialize(struct overlay_data_device_t *dev,
						   overlay_handle_t handle)
	{
		/*
		 * overlay_handle_t should contain all the information to "inflate" this
		 * overlay. Typically it'll have a file descriptor, informations about
		 * how many buffers are there, etc...
		 * It is also the place to mmap all buffers associated with this overlay
		 * (see getBufferAddress).
		 *
		 * NOTE: this function doesn't take ownership of overlay_handle_t
		 *
		 */

		struct overlay_data_context_t* ctx = (struct overlay_data_context_t*)dev;
		int ovid = handle_get_ovId(handle);
		int rotid = handle_get_rotId(handle);
		int size = handle_get_size(handle);
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);
		Mutex::Autolock objLock(m->pobjMutex);

		ctx->pobjDataChannel[0] = new OverlayDataChannel();
		if (!ctx->pobjDataChannel[0]->startDataChannel(ovid, rotid,
		                      size, 0)) {
		    LOGE("Couldnt start data channel for framebuffer 0");
		    delete ctx->pobjDataChannel[0];
		    ctx->pobjDataChannel[0] = 0;
		    return -1;
		}

		char value[PROPERTY_VALUE_MAX];
		property_get("hw.hdmiON", value, "0");
		if (!atoi(value)) {
                    ctx->pobjDataChannel[1] = 0;
                    return 0;
		}

		ovid = handle_get_ovId(handle, 1);
		rotid = handle_get_rotId(handle, 1);
		ctx->pobjDataChannel[1] = new OverlayDataChannel();
		if (!ctx->pobjDataChannel[1]->startDataChannel(ovid, rotid,
		                      size, 1, true)) {
                    LOGE("Couldnt start data channel for framebuffer 1");
                    delete ctx->pobjDataChannel[1];
                    ctx->pobjDataChannel[1] = 0;
		}

		return 0;
	}

	int overlay_dequeueBuffer(struct overlay_data_device_t *dev,
							  overlay_buffer_t* buf)
	{
		/* blocks until a buffer is available and return an opaque structure
		 * representing this buffer.
		 */

		/* no interal overlay buffer to dequeue */
		LOGE("%s: no buffer to dequeue ...\n", __FUNCTION__);

		return 0;
	}

	int overlay_queueBuffer(struct overlay_data_device_t *dev,
							overlay_buffer_t buffer)
	{
		/* Mark this buffer for posting and recycle or free overlay_buffer_t. */
		struct overlay_data_context_t *ctx = (struct overlay_data_context_t*)dev;
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);
		Mutex::Autolock objLock(m->pobjMutex);
		bool result = (ctx->pobjDataChannel[0] &&
		                               ctx->pobjDataChannel[0]->
		                               queueBuffer((uint32_t) buffer));
		if (!result)
		    LOGE("Queuebuffer failed for framebuffer 0");
		else {
		    char value[PROPERTY_VALUE_MAX];
		    property_get("hw.hdmiON", value, "0");
		    if (!atoi(value)) {
                        return 0;
		    }
		    result = (ctx->pobjDataChannel[1] &&
		                               ctx->pobjDataChannel[1]->
		                               queueBuffer((uint32_t) buffer));
		    if (!result) {
			LOGE("QueueBuffer failed for framebuffer 1");
		        return -1;
		    }
		}

		return -1;
	}

	int overlay_setFd(struct overlay_data_device_t *dev, int fd)
	{
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);
		struct overlay_data_context_t* ctx = (struct overlay_data_context_t*)dev;
		Mutex::Autolock objLock(m->pobjMutex);

		bool ret = (ctx->pobjDataChannel[0] &&
		               ctx->pobjDataChannel[0]->setFd(fd));
		if (!ret) {
		    LOGE("set fd failed for framebuffer 0");
		    return -1;
		}

		char value[PROPERTY_VALUE_MAX];
		property_get("hw.hdmiON", value, "0");
		if (!atoi(value)) {
                        return 0;
		}

		ret = (ctx->pobjDataChannel[1] &&
		               ctx->pobjDataChannel[1]->setFd(fd));
		if (!ret) {
		    LOGE("set fd failed for framebuffer 1");
		}

		return 0;
	}

	static int overlay_setCrop(struct overlay_data_device_t *dev, uint32_t x,
                           uint32_t y, uint32_t w, uint32_t h)
	{
		private_module_t* m = reinterpret_cast<private_module_t*>(
		                        dev->common.module);
		struct overlay_data_context_t* ctx = (struct overlay_data_context_t*)dev;
		Mutex::Autolock objLock(m->pobjMutex);
		bool ret = (ctx->pobjDataChannel[0] &&
		               ctx->pobjDataChannel[0]->
			       setCrop(x, y, w, h));
		if (!ret) {
		    LOGE("set crop failed for framebuffer 0");
		    return -1;
		}

		char value[PROPERTY_VALUE_MAX];
		property_get("hw.hdmiON", value, "0");
		if (!atoi(value)) {
                        return 0;
		}

		ret = (ctx->pobjDataChannel[1] &&
		               ctx->pobjDataChannel[1]->
			       setCrop(x, y, w, h));
		if (!ret) {
		    LOGE("set crop failed for framebuffer 1");
		    return -1;
		}
                return 0;
	}

	void *overlay_getBufferAddress(struct overlay_data_device_t *dev,
								   overlay_buffer_t buffer)
	{
		/* overlay buffers are coming from client */
		return( NULL );
	}

	int overlay_getBufferCount(struct overlay_data_device_t *dev)
	{
		return( 0 );
	}


	static int overlay_data_close(struct hw_device_t *dev)
	{
		struct overlay_data_context_t* ctx = (struct overlay_data_context_t*)dev;
		if (ctx) {
			/* free all resources associated with this device here
			 * in particular all pending overlay_buffer_t if needed.
			 *
			 * NOTE: overlay_handle_t passed in initialize() is NOT freed and
			 * its file descriptors are not closed (this is the responsibility
			 * of the caller).
			 */

			if (ctx->pobjDataChannel[0]) {
			    ctx->pobjDataChannel[0]->closeDataChannel();
			    delete ctx->pobjDataChannel[0];
			    ctx->pobjDataChannel[0] = 0;
			}

			if (ctx->pobjDataChannel[1]) {
			    ctx->pobjDataChannel[1]->closeDataChannel();
			    delete ctx->pobjDataChannel[1];
			    ctx->pobjDataChannel[1] = 0;
			}

			free(ctx);
		}
		return 0;
	}

/*****************************************************************************/

	static int overlay_device_open(const struct hw_module_t* module, const char* name,
								   struct hw_device_t** device)
	{
		int status = -EINVAL;

		private_module_t* m = reinterpret_cast<private_module_t*>
					(const_cast<hw_module_t*>(module));
		if (!m->pobjMutex)
			m->pobjMutex = new Mutex();

		if (!strcmp(name, OVERLAY_HARDWARE_CONTROL)) {
			struct overlay_control_context_t *dev;
			dev = (overlay_control_context_t*)malloc(sizeof(*dev));

			if (!dev)
				return status;

			/* initialize our state here */
			memset(dev, 0, sizeof(*dev));

			/* initialize the procs */
			dev->device.common.tag = HARDWARE_DEVICE_TAG;
			dev->device.common.version = 0;
			dev->device.common.module = const_cast<hw_module_t*>(module);
			dev->device.common.close = overlay_control_close;

			dev->device.get = overlay_get;
			dev->device.createOverlay = overlay_createOverlay;
			dev->device.destroyOverlay = overlay_destroyOverlay;
			dev->device.setPosition = overlay_setPosition;
			dev->device.getPosition = overlay_getPosition;
			dev->device.setParameter = overlay_setParameter;
			dev->device.commit = overlay_commit;

			*device = &dev->device.common;
			status = 0;
		} else if (!strcmp(name, OVERLAY_HARDWARE_DATA)) {
			struct overlay_data_context_t *dev;
			dev = (overlay_data_context_t*)malloc(sizeof(*dev));

			if (!dev)
				return status;

			/* initialize our state here */
			memset(dev, 0, sizeof(*dev));

			/* initialize the procs */
			dev->device.common.tag = HARDWARE_DEVICE_TAG;
			dev->device.common.version = 0;
			dev->device.common.module = const_cast<hw_module_t*>(module);
			dev->device.common.close = overlay_data_close;

			dev->device.initialize = overlay_initialize;
	                dev->device.setCrop = overlay_setCrop;
			dev->device.dequeueBuffer = overlay_dequeueBuffer;
			dev->device.queueBuffer = overlay_queueBuffer;
			dev->device.setFd = overlay_setFd;
			dev->device.getBufferAddress = overlay_getBufferAddress;
			dev->device.getBufferCount = overlay_getBufferCount;

			*device = &dev->device.common;
			status = 0;
		}
		return status;
	}
