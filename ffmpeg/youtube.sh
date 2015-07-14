#!/bin/sh
# This encodes a video to be suitable for upload to YouTube
# INPUT HAS TO BE PROGRESSIVE!

INPUT=$1
OUTPUT=$INPUT-youtube

# Check for input
if [ -z "$1" ]; then
	echo "Needs a file to convert" >&2
	exit 1
else
	# Ratefactor can be varied according to taste
	ffmpeg -i "$INPUT" -c:a libopus -b:a 128k -c:v libx264 -crf 25 -sn $OUTPUT.mkv
fi
