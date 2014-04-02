##----------------------------------------------------------------------------
# Created with genmake.pl v1.1 on Wed Apr  2 08:37:36 2014
# genmake.pl home: http://muquit.com/muquit/software/
# Copryright: GNU GPL (http://www.gnu.org/copyleft/gpl.html)
##----------------------------------------------------------------------------
CC = cc
PROGNAME = dynamic-panel
INCLUDES = -pthread -I/usr/include/libwnck-1.0 -I/usr/include/startup-notification-1.0 -I/usr/include/gtk-2.0 -I/usr/lib/gtk-2.0/include -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/libdrm -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng16 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/harfbuzz -lwnck-1 -lgtk-x11-2.0 -lgdk-x11-2.0 -lpangocairo-1.0 -latk-1.0 -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lpangoft2-1.0 -lpango-1.0 -lgobject-2.0 -lglib-2.0 -lfontconfig -lfreetype
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
	rm -f $(OBJS) $(PROGNAME) core *~

install: all
	test -d /usr/share/dynamic-panel || mkdir -m 755 /usr/share/dynamic-panel
	test -d /usr/share/themes/Dynamic/gnome-shell || mkdir -m 755 -p /usr/share/themes/Dynamic/gnome-shell
	$(INSTALL) $(PROGNAME) $(PROGNAME).sh /usr/bin
	$(INSTALLDATA) *.diff /usr/share/dynamic-panel
	$(INSTALLDATA) Dynamic/gnome-shell/* /usr/share/themes/Dynamic/gnome-shell

uninstall: all
	rm -rf /usr/share/dynamic-panel /usr/share/themes/Dynamic /usr/bin/dynamic-panel /usr/bin/dynamic-panel.sh