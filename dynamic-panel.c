#include <gdk/gdk.h>
#define WNCK_I_KNOW_THIS_IS_UNSTABLE
#include <libwnck/libwnck.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
int width;

char* grab_pix_color(int x, int y){
	XColor c;
	Display *d = XOpenDisplay((char *) NULL);

	XImage *image;
	image = XGetImage (d, RootWindow (d, DefaultScreen (d)), x, y, 1, 1, AllPlanes, XYPixmap);
	c.pixel = XGetPixel (image, 0, 0);
	XFree (image);
	XQueryColor (d, DefaultColormap(d, DefaultScreen (d)), &c);

	char* string_color = (char*)malloc(sizeof(char)*32);
	int luminance = 0.2126 * c.red/256 + 0.7152 * c.green/256 + 0.0722 * c.blue/256;
	sprintf(string_color, "\"rgb(%d, %d, %d)\" \"%d\"", c.red/256, c.green/256, c.blue/256, luminance);
	return string_color;
}

void run_program() {
	usleep(300000);
	char* string_color = grab_pix_color((width / 2), 27);
	char* program = "dynamic-panel.sh ";
	char* command = (char*)malloc(sizeof(char)*(strlen(program) + strlen(string_color) + 1));
	strcpy(command, program);
	strcat(command, string_color);
	system(command);
	free(string_color);
	free(command);
}

static void
window_changed(WnckScreen *screen)
{
	if (wnck_window_is_fullscreen(wnck_screen_get_active_window(screen))) {
		system("dynamic-panel.sh --reset");
	}
	else {
		if (wnck_window_is_maximized(wnck_screen_get_active_window(screen))) {
			run_program();
		}
		else {
			system("dynamic-panel.sh --reset");
		}
	}
}

static void
state_changed(WnckWindow *window)
{
	if (wnck_window_is_fullscreen(window)) {
		system("dynamic-panel.sh --reset");
	}
	else {
		if (wnck_window_is_maximized(window)) {
			run_program();
		}
		else {
			system("dynamic-panel.sh --reset");
		}
	}
}

static void
window_opened(WnckScreen *screen, WnckWindow *window)
{
	g_signal_connect(window, "state-changed",
					 G_CALLBACK(state_changed), NULL);
}

gint
main(gint argc, gchar *argv[])
{
	GMainLoop *loop;
	WnckScreen *screen;

	gdk_init(&argc, &argv);

	screen = wnck_screen_get(0);
	width = wnck_screen_get_width(screen);
	g_signal_connect(screen, "active-window-changed",
					 G_CALLBACK(window_changed), NULL);
	g_signal_connect(screen, "window-opened",
					 G_CALLBACK(window_opened), NULL);

	loop = g_main_loop_new(NULL, FALSE);
	g_main_loop_run(loop);
	g_main_loop_unref(loop);

	return 0;
}
