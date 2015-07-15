# This one is for encoding a video to shove on a phone and watch using something
# like VLC

# First, dvdbackup or similar should be used to give an input video
# 96kbps Opus might be a bit small for some purposes
ffmpeg -i input_file.ext -c:v libx264 -preset slow -crf 25 -vf yadif -c:a libopus -b:a 96k out.mkv
