#!/bin/bash

# Set the input folder and output folder paths
input_folder="."
input_folder="c:\\Users\\epsde\\Downloads\\KEEP\\FLACs"

# Set output folder
output_folder="_convert"

# Check if the folder exists
if [ ! -d "$output_folder" ]; then
    # Create the folder if it does not exist
    mkdir -p "$output_folder"
    echo "Folder created: $output_folder"
else
    echo "Folder already exists: $output_folder"
fi

# List of supported audio file extensions
extensions_to_convert=("mp4" "mkv" "webm" "wav" "flac" "ogg" "aiff")

# Convert all audio files in the input folder to 320kbps MP3 using ffmpeg
for file in "$input_folder"/*; do
    if [[ -f "$file" ]]; then
        # Extract the file name and extension
        filename=$(basename "$file")
        extension="${filename##*.}"

		if [[ " ${extensions_to_convert[@]} " =~ " ${extension} " ]]; then
			# Remove the extension from the file name
			filename="${filename%.*}"

			# Set the output file name and path
			output_file="$output_folder/$filename.mp3"

			# Convert the audio file to 320kbps MP3 using ffmpeg
			ffmpeg -i "$file" -b:a 320k "$output_file"
			
			echo "Converted $filename.$extension to $filename.mp3"
		else
			echo "$filename.$extension was NOT be converted"
		fi		
    fi
done
