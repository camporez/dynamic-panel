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
- Run the script
```
$ bash dynamic-panel.sh
```

[1]: https://extensions.gnome.org/extension/19/user-themes/