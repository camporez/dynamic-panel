#Dynamic Panel

![Preview](https://cloud.githubusercontent.com/assets/5755892/2597331/c53ac858-bab2-11e3-88a7-29937b009853.png)

#How it works

The program uses a library called [`libwnck`][1] to receive signals when the window in focus or its state is changed and, if the current window in focus is maximized, it calls a function to grab the color above the panel and generates a new GNOME Shell theme based on this color. If the current window isn't maximized or is fullscreen, it will use the original theme.

##Install

- Clone this repository to your machine.
- Make sure you have the [User Themes][2] extension installed and enabled.
- Compile and install the program.
```
$ make
$ sudo make install
```

##Run

```
$ dynamic-panel
```

##Autostarting the program

- Copy the .desktop file to your autostart directory.
```
$ cp dynamic-panel.desktop $HOME/.config/autostart
```

[1]: https://developer.gnome.org/libwnck/stable/
[2]: https://extensions.gnome.org/extension/19/user-themes/