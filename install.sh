#!/bin/bash

##Creator  : S9yd3R
##Telegram : S9y_d3R
##github   : S9yd3R

#Termux Desktop version :)

#colors
red="\033[1;91m"
cyan="\033[1;36m"
green="\033[1;92m"
white="\033[1;37m"
yellow="\033[1;95m"
reset="\033[0m"


#functions
banner() {
	cat <<"EOF"

             ..                                                  
   .H88x.  :~)88:    oec :                               xeee    
  x888888X ~:8888   @88888                              d888R    
 ~   "8888X  %88"   8"*88%        .        .u          d8888R    
      X8888         8b.      .udR88N    ud8888.       @ 8888R    
   .xxX8888xxxd>   u888888> <888'888k :888'8888.    .P  8888R    
  :88888888888"     8888R   9888 'Y"  d888 '88%"   :F   8888R    
  ~   '8888         8888P   9888      8888.+"     x"    8888R    
 xx.  X8888:    .   *888>   9888      8888L      d8eeeee88888eer 
X888  X88888x.x"    4888    ?8888u../ '8888c. .+        8888R    
X88% : '%8888"      '888     "8888P'   "88888%          8888R    
 "*=~    `""         88R       "P'       "YP'        "*%%%%%%**~ 
                     88>                                         
                     48                                          
                     '8                         By S9yd3R                 
						Telegram : @S9y_d3R


						

EOF

}

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
	pkgs=(lsd x11-repo xfce4 polybar tigervnc geany qterminal audacious)
	for pkg_ in "${pkgs[@]}" ; do
		if ! hash ${pkg_} > /dev/null 2>&1;
		then
			echo -e "\n${white}[ ${red}!${white} ] ${cyan}Installing ${red} ${pkg_}${reset}\n\n"
			apt install "${pkg_}" -y
		fi
	done
}
binary_files() {
	cat > ~/.vnc/xstartup <<- _EOF_
	#!/data/data/com.termux/files/usr/bin/sh
## This file is executed during VNC server
## startup.

# Launch terminal emulator Aterm.
# Requires package 'aterm'.
aterm -geometry 80x24+10+10 -ls &

# Launch Tab Window Manager.
# Requires package 'xorg-twm'.
xfce4-session &
_EOF_
	cat > $PREFIX/bin/vncstart <<- _EOF_
	vncserver -kill :1 > /dev/null 2>&1
	vncserver -geometry 1508x720 -xstartup $PREFIX/bin/xfce4-session -listen tcp :1
	termux-open vnc://127.0.0.1:5901
	_EOF_
	chmod 777 $PREFIX/bin/vncstart
	echo "vncserver -kill :1" > $PREFIX/bin/vncstop
	chmod 777 $PREFIX/bin/vncstop
}

tar -xf ./.files/themes.tar
tar -xf ./.files/icons.tar
mv ./.files/themes $PREFIX/share/
mv ./.files/icons $PREFIX/shate/

change_theme
properties
echo -e "${yellow}"
banner
echo -e "${reset}"
sleep 2
echo -e "${cyan}Installing required pkgs this may take a while . Grab a cup of coffee${reset}"
echo "alias ls=\"lsd\"" >> $PREFIX/etc/bash.bashrc
termux-reload-settings
install_pkgs
echo -e "${red}Requirements satisfied !${reset}"
sleep 2
clear
binary_files
echo -e "${red}Quick Note !${reset}"
echo -ne "\n${cyan}vncstart${reset}\tto start vncserver\n${cyan}vncstop${reset}\t\tto stop vncserver\n${cyan}vncserver\"
