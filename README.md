#How it works
- The script starts a loop, calling the `grab_pix_color` program to grab the color below the panel;
- If this color changes, the script grabs the [luminance][2], using the program `grab_luminance`, generates and apply a new theme.

#How it should work
- The script receives a signal when the window in focus is maximized, grab the color and generates/applies the new theme.
- If the window in focus is not maximized, the script applies the default theme.

#Install

- Clone this repository to your machine.
- Make sure you have the [User Themes][1] extension installed and enabled.
- Compile the two .cpp files and move the output files to a directory in your $PATH.
```
$ g++ grab_pix_color.cpp -o grab_pix_color -lX11 -fpermissive
$ g++ grab_pix_color.cpp -o grab_luminance -lX11 -fpermissive
$ sudo mv grab_pix_color grab_luminance /usr/bin
```
- Copy the theme to the themes directory
```
$ cp -r Dynamic $HOME/.local/share/themes
```

#Run

```
$ bash dynamic-panel.sh
```

[1]: https://extensions.gnome.org/extension/19/user-themes/
[2]: http://en.wikipedia.org/wiki/Luminance_(relative)#cite_ref-2