#!/bin/sh
# This encodes a video to be able to be played on a bluray player
# INPUT VIDEO HAS TO BE PROGRESSIVE!
# This does not convert the audio, due to the free AAC encoders being rubbish

# Parameters
INPUT=$1

# Check for input
if [ -z "$1" ]; then
	echo "Needs an input file" >&2
	exit 1
else
	# Speed preset and ratefactor can be changed to suit
	ffmpeg -i "$INPUT" -c:v libx264 -level 4.1 -preset veryslow -tune film -crf 18 -r 25 -g 25 -maxrate 40000 -bufsize 30000 -x264opts bluray-compat=1:open-gop=1:slices=4:fake-interlaced=1:colorprim=bt709:transfer=bt709:colormatrix=bt709:sar=1/1 -c:a copy out.mkv
fi
