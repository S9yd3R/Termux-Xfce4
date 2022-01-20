#!/bin/bash
#Termux Desktop version :)

#colors
red="\033[1;91m"
cyan="\033[1;36m"
grey="\033[1;90m"
green="\033[1;92m"
blink="\e[5m"
magenta="\033[1;95m"

change_theme() {
	cat > ~/.termux/colors.properties <<- _EOF_
		foreground=#c8ccd4
		background=#1e222a
		#cursor=#e06c75
		color0=#1e222a
		color1=#e06c75
		color2=#98c379
		color3=#e5c07b
		color4=#61afef
		color5=#c678dd
		color6=#56b6c2
		#color7=#abb2bf
		color7=#D8DEE9
		color8=#545862
		color9=#e06c75
		color10=#98c379
		color11=#e5c07b
		color12=#61afef
		color13=#c678dd
		color14=#56b6c2
		color15=#c8ccd4
	_EOF_

	cat > ~/.termux/termux.properties <<- _EOF_

	_EOF_
}



install_pkgs() {
	pkgs=(x11-repo xfce4 polybar tigervnc geany audacious)
	for i in "${pkgs[@]}" ; do
		if ! hash ${i} > /dev/null 2>&1;
		then
			echo -e ""
			apt install "${i}" -y
		fi
	done
}

