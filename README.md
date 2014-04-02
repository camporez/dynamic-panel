#Install

- Clone this repository to your machine.
- Make sure you have the [User Themes][1] extension installed and enabled.
- Compile the two .cpp files and move the output files to a directory in your $PATH.
```
$ gcc $(pkg-config --cflags --libs libwnck-1.0) dynamic-panel.c -o dynamic-panel -lX11
```
- Copy the script to a folder in your $PATH (e.g., /usr/bin)
```
$ sudo cp dynamic-panel.sh /usr/bin
```
- Copy the theme to the themes directory
```
$ cp -r Dynamic $HOME/.local/share/themes
```

#Run

```
$ ./dynamic-panel
```

[1]: https://extensions.gnome.org/extension/19/user-themes/
[2]: http://en.wikipedia.org/wiki/Luminance_(relative)#cite_ref-2