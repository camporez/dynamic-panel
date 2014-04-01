/*

grab_pix_color: a component of Dynamic Panel
https://github.com/camporez/dynamic-panel

*/

#include <stdlib.h>
#include <iostream>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

using namespace std;

int main(int argc,char **argv)
{
    XColor c;
    Display *d = XOpenDisplay((char *) NULL);

    int x = (int)atoi(argv[1]);
    int y = (int)atoi(argv[2]);

    XImage *image;
    image = XGetImage (d, RootWindow (d, DefaultScreen (d)), x, y, 1, 1, AllPlanes, XYPixmap);
    c.pixel = XGetPixel (image, 0, 0);
    XFree (image);
    XQueryColor (d, DefaultColormap(d, DefaultScreen (d)), &c);
    cout << "rgb(" << c.red/256 << ", " << c.green/256 << ", " << c.blue/256 << ")\n";

    return 0;
}
