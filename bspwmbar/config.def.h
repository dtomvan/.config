/* See LICENSE file for copyright and license details. */

#ifndef BSPWMBAR_CONFIG_H_
#define BSPWMBAR_CONFIG_H_

#include "bspwmbar.h"

/* intel */
#define THERMAL_PATH "/sys/class/thermal/thermal_zone0/temp"
/* k10temp */
/* #define THERMAL_PATH "/sys/class/hwmon/hwmon1/temp1_input" */

/* max length of monitor output name and bspwm desktop name */
#define NAME_MAXSZ  32
/* max length of active window title */
#define TITLE_MAXSZ 50
/* set window height */
#define BAR_HEIGHT  24

/* set font pattern for find fonts, see fonts-conf(5) */
const char *fontname = "Jetbrains Mono:size=12";

/*
 * color settings by index of color map
 */
/* bspwmbar fg color */
#define FGCOLOR    "#e5e5e5"
/* bspwmbar bg color */
#define BGCOLOR    "#222222"
/* inactive fg color */
#define ALTFGCOLOR "#7f7f7f"
/* graph bg color */
#define ALTBGCOLOR "#555555"

/*
 * Module definition
 */

/* modules on the left */
module_t left_modules[] = {
	{ /* bspwm desktop state */
		.desk = {
			.func = desktops,
			.focused = "",
			.unfocused = "",
			.fg_free = ALTFGCOLOR,
		},
	},
	{ /* active window title */
		.title = {
			.func = windowtitle,
			.maxlen   = TITLE_MAXSZ,
			.ellipsis = "…",
		},
	},
};

/* modules on the right */
module_t right_modules[] = {
	{ /* system tray */
		.tray = {
			.func = systray,
			.iconsize = 16,
		},
	},
	{ /* clock */
		.date = {
			.func = datetime,
			.prefix = "",
			.format = "%H:%M:%S %F",
		},
	},
};

#endif
