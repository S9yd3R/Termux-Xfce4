#!/bin/bash
#Termux Desktop version :)

#colors
red="\033[1;91m"
cyan="\033[1;36m"
green="\033[1;92m"
reset="\033[0m"


#functions

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
	rm -rf ~/.termux/font.ttf
	cp ./.files/font.ttf ~/.termux
}

properties() {
	cat > ~/.termux/termux.properties <<- _EOF_
	extra-keys = [ \
    ['F1' , 'ESC', 'CTRL', 'ALT', 'TAB', {key: KEYBOARD, popup: DRAWER}, 'HOME', 'UP', 'END'], \
    ['DELETE', '{}', '()', '[]', '$', 'BACKSLASH', 'LEFT', 'DOWN', 'RIGHT'] \
]

# fullscreen = true

# use-fullscreen-workaround = true

# Open a new terminal with ctrl + t (volume down + t)
shortcut.create-session = ctrl + t

# Go one session down with (for example) ctrl + 2
shortcut.next-session = ctrl + 2

# Go one session up with (for example) ctrl + 1
shortcut.previous-session = ctrl + 1

# Rename a session with (for example) ctrl + n
shortcut.rename-session = ctrl + u

# Beep with a sound.
# bell-character=beep

# Cursor Blinking
terminal-cursor-blink-rate=600
	_EOF_
}

install_pkgs() {
	pkgs=(lsd x11-repo xfce4 polybar tigervnc geany audacious)
	for pkg_ in "${pkgs[@]}" ; do
		if ! hash ${pkg_} > /dev/null 2>&1;
		then
			sp=( "\033[1;91m⬤   " "\033[1;91m⬤  \033[1;92m⬤" "   \033[1;92m⬤" "\033[0m    ")

        		for i in "${sp[@]}" ; do
        			echo -ne "\rInstalling $pkg_   ${i}"
					sleep 1
				done
		fi
	done
}

echo -e "${cyan}Installing required pkgs this may take a while . Grab a cup of coffee${reset} \n"

change_theme
properties
echo "alias ls=\"lsd\"" >> $PREFIX/etc/bash.bashrc
$SHELL
termux-reload-settings
install_pkgs
