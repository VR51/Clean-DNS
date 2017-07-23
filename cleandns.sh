#!/bin/bash
clear

###
#
#	Clear DNS Caches
#
# Author: Lee Hodson
# URL: https://github.com/VR51/Clean-DNS
# URL: https://journalxtra.com/linux/bash-linuxsanity/script-clean-linux-dns-cache/
#
#
# How to Use
#
#   Download this file (cleandns.sh).
#   Make the script executable.
#   Click the script to run it.
#    Or run it from the commandline with ./cleandns.sh (you will need to be in the same directory as the script)
# 
# Script written because I got annoyed at keying in various commands to clean my DNS cache
# whenever I changed a website's IP address.
#
# Licence: GPL3
#
###

###
#
#	Confirm we are running in a terminal
#		If not, try to launch this program in a terminal
#
###

tty -s

if test "$?" -ne 0
then

	# This code section is released in public domain by Han Boetes <han@mijncomputer.nl>
	# Updated by Dave Davenport <qball@gmpclient.org>
	# Updated by Lee Hodson <https://journalxtra.com> - Added break on successful hit, added more terminals, humanized the failure message, replaced call to rofi with printf and made $terminal an array for easy reuse.
	#
	# This script tries to exec a terminal emulator by trying some known terminal
	# emulators.
	#
	# We welcome patches that add distribution-specific mechanisms to find the
	# preferred terminal emulator. On Debian, there is the x-terminal-emulator
	# symlink for example.

	terminal=( x-terminal-emulator xdg-terminal konsole gnome-terminal terminator urxvt rxvt Eterm aterm roxterm xfce4-terminal termite lxterminal xterm )
	for i in ${terminal[@]}; do
		if command -v $i > /dev/null 2>&1; then
			exec $i -e "$0"
			break
		else
			printf "\nUnable to automatically determine the correct terminal program to run e.g Console or Konsole. Please run this program from a terminal AKA the command line.\n"
			read something
			leave_program
		fi
	done

fi

###
#
#	Obtain Authorisation to update the system
#
###

printf "\nAuthorise System Update to update the system:\n"
sudo -v


###
#
#	Clean cache
#
###


sudo /etc/init.d/networking force-reload
sudo /etc/init.d/dns-clean restart
sudo /etc/init.d/dnsmasq restart
sudo /etc/init.d/nscd restart
