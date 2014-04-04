CC = cc
PROGNAME = dynamic-panel
INCLUDES = -pthread -I/usr/include/libwnck-3.0 -I/usr/include/startup-notification-1.0 -I/usr/include/gtk-3.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/gtk-3.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/harfbuzz -I/usr/include/libdrm -I/usr/include/libpng16 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng16 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -lwnck-3 -lgtk-3 -lgdk-3 -lpangocairo-1.0 -lpango-1.0 -latk-1.0 -lcairo-gobject -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0
LIBS = -lX11
DEFINES= $(INCLUDES) $(DEFS) -DSYS_UNIX=1
CFLAGS= -g $(DEFINES)

SRCS = dynamic-panel.c  

OBJS = dynamic-panel.o  

INSTALL = /usr/bin/install
INSTALLDATA = /usr/bin/install -m 664

.c.o:
	rm -f $@
	$(CC) $(CFLAGS) -c $*.c

all: $(PROGNAME)

$(PROGNAME) : $(OBJS)
	$(CC) $(CFLAGS) -o $(PROGNAME) $(OBJS) $(LIBS)

clean:
	rm -f $(OBJS) $(PROGNAME)

install:
	test -d /usr/share/dynamic-panel || mkdir -m 755 /usr/share/dynamic-panel
	test -d /usr/share/themes/Dynamic/gnome-shell || mkdir -m 755 -p /usr/share/themes/Dynamic/gnome-shell
	$(INSTALL) $(PROGNAME) $(PROGNAME).sh /usr/bin
	$(INSTALLDATA) *.diff /usr/share/dynamic-panel
	$(INSTALLDATA) Dynamic/gnome-shell/* /usr/share/themes/Dynamic/gnome-shell

uninstall:
	rm -rf /usr/share/dynamic-panel /usr/share/themes/Dynamic /usr/bin/dynamic-panel /usr/bin/dynamic-panel.sh
