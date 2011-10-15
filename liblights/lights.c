/*
 * Copyright (C) 2008 The Android Open Source Project
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


// #define LOG_NDEBUG 0
#define LOG_TAG "lights"

#include <cutils/log.h>

#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>

#include <sys/ioctl.h>
#include <sys/types.h>

#include <hardware/lights.h>

/******************************************************************************/

static pthread_once_t g_init = PTHREAD_ONCE_INIT;
static pthread_mutex_t g_lock = PTHREAD_MUTEX_INITIALIZER;
static struct light_state_t g_notification;
static struct light_state_t g_battery;
static int g_backlight = 255;
static int g_buttons = 0;

char const*const RED_LED_FILE = "/sys/class/leds/red/brightness";
char const*const GREEN_LED_FILE = "/sys/class/leds/green/brightness";
char const*const BLUE_LED_FILE = "/sys/class/leds/blue/brightness";

char const*const LCD_BACKLIGHT_FILE = "/sys/class/leds/lcd-backlight/brightness";

char const*const RED_BLINK_FILE = "/sys/class/leds/red/blink";
char const*const GREEN_BLINK_FILE = "/sys/class/leds/green/blink";

char const*const BUTTON_FILE = "/sys/class/leds/button-backlight/brightness";

/* Look ma! Pretty colors... ooooh */
enum {
    RGB_BLACK = 0x000000,
    RGB_RED = 0xFF0000,
    RGB_AMBER = 0xFFFF00,  /* note this is actually RGB yellow */
    RGB_GREEN = 0x00FF00,
    RGB_BLUE = 0x0000FF,
    RGB_WHITE = 0xFFFFFF,
    RGB_PINK = 0xFFC0CB,
    RGB_ORANGE = 0xFFA500,
    RGB_YELLOW = 0xFFFF00,
    RGB_PURPLE = 0x800080,
    RGB_LT_BLUE = 0xADD8E6,
};

/**
 * device methods
 */

void init_globals(void)
{
    // init the mutex
    pthread_mutex_init(&g_lock, NULL);
}

static int write_int(char const* path, int value) {
    int fd;
    static int already_warned = 0;

    fd = open(path, O_RDWR);
    if (fd >= 0) {
        char buffer[20];
        int bytes = sprintf(buffer, "%d\n", value);
        int amt = write(fd, buffer, bytes);
        close(fd);
        return amt == -1 ? -errno : 0;
    } else {
        if (already_warned == 0) {
            LOGE("write_int failed to open %s\n", path);
            already_warned = 1;
        }
        return -errno;
    }
}

static int is_lit(struct light_state_t const* state) {
    return state->color & 0x00ffffff;
}

static int rgb_to_brightness(struct light_state_t const* state) {
    int color = state->color & 0x00ffffff;
    return ((77*((color>>16)&0x00ff))
            + (150*((color>>8)&0x00ff)) + (29*(color&0x00ff))) >> 8;
}

static int set_light_backlight(struct light_device_t* dev,
        struct light_state_t const* state) {
    int err = 0;
    int brightness = rgb_to_brightness(state);
    pthread_mutex_lock(&g_lock);
    g_backlight = brightness;
    err = write_int(LCD_BACKLIGHT_FILE, brightness);
    pthread_mutex_unlock(&g_lock);
    return err;
}

/*
 * KD 2011-10-14 Modify to support PWM control of the button level
 * Note that this requires a kernel that knows how to handle more than
 * "on" and "off"; stock kernel does NOT and will likely react badly to
 * this.  Note that to change the brightness we must cycle off first;
 * while the kernel may be able to avoid this with more patches, we're
 * going to honor the structure of the kernel's flag system for now.
 */

static int set_light_buttons(struct light_device_t* dev,
        struct light_state_t const* state) {
    int err = 0;
    int brightness = rgb_to_brightness(state);
//    int on = is_lit(state);
    pthread_mutex_lock(&g_lock);
//    g_buttons = on;
//    err = write_int(BUTTON_FILE, on?255:0);
    g_buttons = brightness;
    err = write_int(BUTTON_FILE, 0);
    err = write_int(BUTTON_FILE, brightness);
    pthread_mutex_unlock(&g_lock);
    return err;
}

static int set_speaker_light_locked(struct light_device_t* dev,
        struct light_state_t const* state) {

    unsigned int colorRGB = state->color & 0xFFFFFF;

    switch (state->flashMode) {
        case LIGHT_FLASH_TIMED:
            switch(colorRGB) {
		case RGB_RED:
		    write_int(RED_BLINK_FILE, 1);
		    write_int(GREEN_LED_FILE, 0);
		    write_int(BLUE_LED_FILE, 0);
		    LOGD("set_led_state colorRGB=%08X\n", colorRGB);
		    break;
		case RGB_GREEN:
		    write_int(RED_LED_FILE, 0);
		    write_int(GREEN_BLINK_FILE, 1);
		    write_int(BLUE_LED_FILE, 0);
		    LOGD("set_led_state colorRGB=%08X\n", colorRGB);
		    break;
		case RGB_BLUE:
		    write_int(RED_LED_FILE, 1); /* Triumph doesn't have blue, so I'll set yellow. */
		    write_int(GREEN_LED_FILE, 1);
		    write_int(BLUE_LED_FILE, 0);
		    LOGD("set_led_state colorRGB=%08X\n", colorRGB);
		    break;
		case RGB_BLACK: /* LED off */
		    write_int(RED_LED_FILE, 0);
		    write_int(GREEN_LED_FILE, 0);
		    write_int(BLUE_LED_FILE, 0);
		    LOGD("set_led_state colorRGB=%08X\n", colorRGB);
		    break;
		default:
		    write_int(RED_BLINK_FILE, 1); /* Triumph doesn't have "all", so I'll set flashing yellow. */
		    write_int(GREEN_BLINK_FILE, 1);
		    write_int(BLUE_LED_FILE, 0);
		    LOGD("set_led_state (all LEDs flash on) colorRGB=%08X\n", colorRGB);
		    break;
	    }
	    break;
        case LIGHT_FLASH_NONE:
	    switch(colorRGB) {
		case RGB_RED:
		    write_int(RED_LED_FILE, 1);
		    write_int(GREEN_LED_FILE, 0);
		    write_int(BLUE_LED_FILE, 0);
		    LOGD("set_led_state colorRGB=%08X\n", colorRGB);
		    break;
		case RGB_GREEN:
		    write_int(RED_LED_FILE, 0);
		    write_int(GREEN_LED_FILE, 1);
		    write_int(BLUE_LED_FILE, 0);
		    LOGD("set_led_state colorRGB=%08X\n", colorRGB);
		    break;
		case RGB_BLUE:
		    write_int(RED_LED_FILE, 0);
		    write_int(GREEN_LED_FILE, 0);
		    write_int(BLUE_LED_FILE, 1);
		    LOGD("set_led_state colorRGB=%08X\n", colorRGB);
		    break;
		case RGB_BLACK: /* LED off */
		    write_int(RED_LED_FILE, 0);
		    write_int(GREEN_LED_FILE, 0);
		    write_int(BLUE_LED_FILE, 0);
		    LOGD("set_led_state colorRGB=%08X\n", colorRGB);
		    break;
		default:
		    write_int(RED_LED_FILE, 1);
		    write_int(GREEN_LED_FILE, 0);
		    write_int(BLUE_LED_FILE, 0);
		    LOGE("set_led_state colorRGB=%08X, enable red (charging)\n", colorRGB);
		    break;
	    }
	    break;
	default:
	    LOGE("set_led_state colorRGB=%08X, unknown mode %d\n", colorRGB, state->flashMode);
    }
    return 0;
}

/* Allow notifications while battery is charging */
static void set_speaker_light_dual_locked(struct light_device_t *dev, struct light_state_t *bstate, 
    struct light_state_t *nstate) {

    unsigned int bcolorRGB = bstate->color & 0xFFFFFF;
    unsigned int ncolorRGB = nstate->color & 0xFFFFFF;
    
    LOGD("set_led_state (plugged) ncolorRGB=%08X, bcolorRGB=%08X\n", ncolorRGB, bcolorRGB);	
    if(bcolorRGB == RGB_RED) {
	write_int(RED_LED_FILE, 1);
	write_int(GREEN_BLINK_FILE, 1);
	write_int(BLUE_LED_FILE, 0);
	LOGD("set_led_state (dual) bcolorRGB=%08X\n", bcolorRGB);	
    } else if(bcolorRGB == RGB_GREEN) {
	write_int(RED_BLINK_FILE, 1);
	write_int(GREEN_LED_FILE, 1);
	write_int(BLUE_LED_FILE, 0);
	LOGD("set_led_state (dual) bcolorRGB=%08X\n", bcolorRGB); 
    } else {
	write_int(RED_LED_FILE, 1);	/* Set red/orange flash */
	write_int(GREEN_BLINK_FILE, 1);
	write_int(BLUE_LED_FILE, 0);
	LOGD("set_led_state (Plugged, Orange/Red flash) colorRGB=%08X\n", bcolorRGB);
    }
}

static void handle_speaker_battery_locked(struct light_device_t* dev) {
    if (is_lit(&g_battery) && is_lit(&g_notification)) {
        set_speaker_light_dual_locked(dev, &g_battery, &g_notification);
    } else if (is_lit(&g_battery)) {
        set_speaker_light_locked(dev, &g_battery);
    } else {
        set_speaker_light_locked(dev, &g_notification);
    }
}

static int set_light_battery(struct light_device_t* dev,
        struct light_state_t const* state) {
    pthread_mutex_lock(&g_lock);
    g_battery = *state;
    handle_speaker_battery_locked(dev);
    pthread_mutex_unlock(&g_lock);
    return 0;
}

static int set_light_notifications(struct light_device_t* dev,
        struct light_state_t const* state) {
    pthread_mutex_lock(&g_lock);
    g_notification = *state;
    handle_speaker_battery_locked(dev);
    pthread_mutex_unlock(&g_lock);
    return 0;
}

/* What the hell is this? */
static int set_light_attention(struct light_device_t* dev,
        struct light_state_t const* state) {
    return 0;
}


/** Close the lights device */
static int close_lights(struct light_device_t *dev) {
    if (dev) {
        free(dev);
    }
    return 0;
}


/******************************************************************************/

/**
 * module methods
 */

/** Open a new instance of a lights device using name */
static int open_lights(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device) {

    int (*set_light)(struct light_device_t* dev,
            struct light_state_t const* state);

    if (0 == strcmp(LIGHT_ID_BACKLIGHT, name)) {
        set_light = set_light_backlight;
    }
    else if (0 == strcmp(LIGHT_ID_BUTTONS, name)) {
        set_light = set_light_buttons;
    }
    else if (0 == strcmp(LIGHT_ID_BATTERY, name)) {
        set_light = set_light_battery;
    }
    else if (0 == strcmp(LIGHT_ID_NOTIFICATIONS, name)) {
        set_light = set_light_notifications;
    }
    else if (0 == strcmp(LIGHT_ID_ATTENTION, name)) {
        set_light = set_light_attention;
    }
    else {
        return -EINVAL;
    }

    pthread_once(&g_init, init_globals);

    struct light_device_t *dev = malloc(sizeof(struct light_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*)module;
    dev->common.close = (int (*)(struct hw_device_t*))close_lights;
    dev->set_light = set_light;

    *device = (struct hw_device_t*)dev;
    return 0;
}


static struct hw_module_methods_t lights_module_methods = {
    .open =  open_lights,
};

/*
 * The lights Module
 */
const struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = LIGHTS_HARDWARE_MODULE_ID,
    .name = "Triumph lights Module",
    .author = "ikarosdev",
    .methods = &lights_module_methods,
};
