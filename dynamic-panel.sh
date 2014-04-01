#!/bin/bash
# Dynamic Panel 0.1-dev
# https://github.com/camporez/dynamic-panel

testCurrentColor() {
	if [ "$1" == "$WALLPAPER" ] || [ "$1" == "$OVERVIEW" ]; then
		STYLE="original"
		gsettings set org.gnome.shell.extensions.user-theme name "$( basename "$THEME" )"
		rm -rf "$THEME"-*
	elif [ $2 -gt 179 ]; then
		STYLE="clean"
		changeTheme "$1" "$STYLE" "`echo "$CURRENT_COLOR" | sed 's/[^0-9]//g'`"
	else
		STYLE="dark"
		changeTheme "$1" "$STYLE" "`echo "$CURRENT_COLOR" | sed 's/[^0-9]//g'`"
	fi
}

changeTheme() {
	rm -rf "$THEME"-*
	cat "/home/ian/Projetos/massive-dynamic-panel/$2.diff" | sed "s/HEADER_COLOR/$1/g" > "/tmp/current.diff"
	cp -r "$THEME" "$THEME-$3"
	patch -s "$THEME-$3/gnome-shell/gnome-shell.css" "/tmp/current.diff"
	gsettings set org.gnome.shell.extensions.user-theme name "$( basename "$THEME-$3" )"
}

WIDTH=$( expr `xdpyinfo | sed -n 's/.*dim.* \([0-9]*x[0-9]*\) .*/\1/pg' | cut -f1 -d'x'` / 3 )
THEME="$HOME/.local/share/themes/Dynamic"
WALLPAPER="rgb(99, 196, 176)"
OVERVIEW="rgb(20, 39, 35)"
while true; do
	CURRENT_COLOR=$( grab_pix_color $WIDTH 27 )
	if [ "$CURRENT_COLOR" != "$LAST_COLOR" ]; then
		LUMINANCE=$( grab_luminance `echo "$CURRENT_COLOR" | sed 's/[rgb(,)]//g'` )
		testCurrentColor "$CURRENT_COLOR" "$LUMINANCE"
		if [ "$1" == "-v" ]; then
			tee -a "dynamic-panel.log" <<< "[`date +%T`] $CURRENT_COLOR: applying $STYLE theme for luminance $LUMINANCE."
		fi
	fi
	LAST_COLOR="$CURRENT_COLOR"
	trap 'rm -rf "$THEME/Dynamic-*"; gsettings set org.gnome.shell.extensions.user-theme name "$( basename "$THEME" )" && tee -a "dynamic-panel.log" <<< "[`date +%T`] reversed to the original theme." && exit' 2
	sleep 0.1
done
