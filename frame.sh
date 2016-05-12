#!/bin/bash

banner () {
	echo "FRAMER"
	echo " "
	echo "Modifies images in place, adding a 1px black border."
	echo "If a directory is given, a border will be added to all"
	echo ".png, .jp(e)g, and gif files found in the folder."
	echo " "
	echo "[Requires imagemagick to be installed.]"
	echo " "
	echo "USAGE:"
	echo "      $0 filename"
	echo "      $0 dirname"
}

frame_one () {
	convert "$1" -shave 1x1 -bordercolor black -border 1 "$1"
}

frame_dir () {
	echo "Framing directory $1"

	for file in {"${1}"/*.png,"${1}"/*.jpg,"${1}"/*.jpeg,"${1}"/*.gif}
	do
		if [ -e "$file" ]
		then
			frame_one "$file"
		fi
	done
}

# no args -> banner
if [[ $# -eq 0 ]]; then
		banner
		exit 0
fi

# test arg is a directory
if [[ -d $1 ]]; then
	frame_dir "$1"
# test arg is a file
elif [[ -f $1 ]]; then
	frame_one "$1"
else
	echo "$1 does not exist!"
	exit 1
fi