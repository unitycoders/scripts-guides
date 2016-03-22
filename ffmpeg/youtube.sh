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
	# See https://support.google.com/youtube/answer/1722171?hl=en
	# Summary:
	# ffmpeg native AAC encoder, set for stereo recommended bitrate
	# -preset slow -> Set to the slowest preset that you can be bothered with
	# -crf 25 -> Somewhat arbitrary, see document above for bitrate guidance, CRF mode should be better quality than 1 pass VBR
	# -g 12 -> GOP size of 12, should be half of framerate
	# -bf 2 -> Number of consecutive b frames
	# -flags +cgop -> closed GOP
	# -pix_fmt yuv420p -> YUV 4:2:0 subsampling
	# -tune film -> For live action videos, feel free to choose another tune parameter
	ffmpeg -i "$INPUT" -c:a aac -strict -2 -b:a 384k -c:v libx264 -preset slow -crf 25 -g 12 -bf 2 -flags +cgop -pix_fmt yuv420p -tune film $OUTPUT.mp4
fi
