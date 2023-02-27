#!/bin/bash
# NOTE : Quote it else use array to avoid problems #
for f in *.opus
do
 
	echo "Converting file - \"$f\""
	# always "double quote" $f to avoid problems
	echo "$f"
	
	ffmpeg -i "$f" -b:a 320k "$f.mp3"
done