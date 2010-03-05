#!/bin/bash -i
					# -i is needed so that PS1 is available
# bash-tutor.sh Interactive live bash tutorial script with style.
# Copyright (C) 2010  James Shubin
# Written by James Shubin <purpleidea@gmail.com>
# Thanks to ferret@gentoo/user/ferret on #bash@freenode for PS1 parsing answer.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# README:
# This is a simple bash script to run appropriately crafted bash tutorial files
# which should hopefully help the tutee feel more comfortable navigating a bash
# shell and executing streams of commands. It has been designed with style as a
# primary objective, and easy of use in crafting tutorials as a secondary goal.
# This script would like to give props to the [A|L]GPL licenses and typescript.
#
# EXAMPLE:
# ./bash\ tutor.sh [-s <typescript>] <tutorial filename>
# press [ENTER] after each command is typed to run it
# press any key while command is typing to quick skip through typing animation
# [script commands and output follows]

# NOTE:	Be warned that scripts *actually* execute the commands, they don't sim.

# TODO: add pexpect style interactive style editing... kind of like tryruby.org

NAME=`basename "$0" .sh`
VERSION="0.1"

# simple usage function
function usage()
{
	echo -e "usage: ./"`basename "$0"`" -h | --help"
	echo -e "usage: ./"`basename "$0"`" -v | --version"
	echo -e "usage: ./"`basename "$0"`" [-s | --typescript] <filename>"
	# TODO: write a self-hosting demo if possible!
	#echo -e "usage: ./"`basename "$0"`" -d | --demo"
	echo -e "run the tutorial file with or without recorded a typescript"
	echo -e "-h --help\tshow this usage message; see source for examples"
	echo -e "-v --version\tshow the program name, version and license"
	echo -e "-s --typescript\tsave a typescript file for passive replaying"
	# TODO: write a self-hosting demo if possible!
	#echo -e "-d --demo\tdemo this software with a self-hosting tutorial!"
}


# echo text using ansi escape sequences but not escaped. capture the output
# from this function with backticks, and run it with echo -e to see colour.
function red()
{
	echo "\033[31m$1\033[0m"
}


function green()
{
	echo "\033[32m$1\033[0m"
}


function blue()
{
	echo "\033[34m$1\033[0m"
}


# show text passed to this function behind an appropriately named prompt.
# if you pass this function -n, then it uses echo -n instead of plain old echo.
function msg()
{
	echo -ne `blue "[$NAME]"`	# the prompt in blue
	echo -n " "			# one white space
	echo $1 "$2"			# pass any flags and $2 if it exists
}


# show a coloured `press [ENTER] to continue' prompt which dissapears on press.
function enter()
{
	msg -ne "press "`green "[ENTER]"`" to continue... "
	read -s				# -s silent mode, characters not echoed
					# read: $ man 1 tput && man 5 terminfo
	tput el1			# clear to beginning of line
	tput hpa 0			# horizontal position absolute
}


# run a semi-interactive command with this system
function cmd()
{
	#echo "$ $1"			# see the command (normal)
	#echo -n "$ "			# show the prompt
	#echo -en "\033[34m$ \033[0m"	# coloured prompt
					# show users their prompt instead!
	# FIXME: slow and hacky... parsing the PS1 directly would be better.
	# TODO: research the debian bash-builtins package, which installs into:
	# /usr/share/doc/bash/examples/loadables/ and might let us use the fast
	# c PS1 parser for use in our scripts to speed this slow bottleneck up?
					# this functionality counts as style!
	echo -n "$(bash -i <<<$'\nexit' 2>&1 > /dev/null | head -n 1)"
	# type out each letter of the command. homebrew heuristic for timing.
	skip=false			# initialize or reset the skip
	for i in `seq 0 ${#1}`; do
		if $skip; then		# echo what's left and skip the wait...
			echo -n "${1:$i}"
			break
		fi

		echo -n "${1:$i:1}"	# variable is $1, and length is 1
		let "sec = $RANDOM % 5"	# random time to emulate human typing
		sec=`echo $sec / 20 | bc -l`
		#sleep 0.1s		# sleep (normal)
		#sleep "$sec"s		# sleep fraction
		read -s -n 1 -t $sec x	# sleep w/ keypress-skip via read (wow)
		# NOTE: if sec is 0, then it will be unlikely that the key hits
		if [ $? -eq 0 ]; then skip=true; fi

	done
	read -s				# wait for a keypress
	# TODO: we could run different things based on keypress; eg: edit, skip
	echo ""				# looks like [ENTER] was pressed
	eval $1				# execute the command (eval is needed!)
}


# show usage with no args or help style args
if [ "$1" = "" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
	usage
	exit `true`
fi

# show version
if [ "$1" = "-v" ] || [ "$1" = "--version" ]; then
	echo -e `blue "$NAME"`", version $VERSION"
	# the minus in the heredoc title suppresses leading tabs (-:
	# there's no reason your code has to look like sh_t and not be indented
	cat <<-LICENSE
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as
	published by the Free Software Foundation, either version 3 of the
	License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU Affero General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
	LICENSE
	exit `true`
fi

# check for typescript
if [ "$1" = "-s" ] || [ "$1" = "--typescript" ]; then
	# TODO: do typescript...
	echo 'Not yet implemented, coming soon.'
	#script
	shift				# get rid of this arg
fi

# run a self-hosting demo
if [ "$1" = "-d" ] || [ "$1" = "--demo" ]; then
	# TODO: make a demo...
	echo 'Not yet implemented, coming soon.'
	exit
fi

# check for filename
if [ "$1" = "" ] || [ ! -e "$1" ]; then
	usage
	exit `true`
fi

# run the tutorial
# TODO: sourcing of a regular script file could cause it to get parsed and sent
# into this script with cmd() calls prepended on valid commands. magic comments
# could be parsed to add in things like the enter() and msg() calls.
source "$1"

