import os
import tkinter as tk
from tkinter import filedialog
from mutagen import File

removeTags = True

# Create a Tkinter window
root = tk.Tk()
root.withdraw()

# Show the file selection dialog and get the selected input folder
input_folder = filedialog.askdirectory(title="Select Input Folder")

# Check if the input folder exists
if not os.path.isdir(input_folder):
    print("Error: The selected folder does not exist.")
    exit()

# Set the output folder path
output_folder = "_convert"

# Check if the output folder exists, and create it if it doesn't
if not os.path.isdir(output_folder):
    os.mkdir(output_folder)
    
# List of supported audio and video file extensions
supported_extensions = [".wav", ".flac", ".ogg", "aiff", ".mkv", ".mp4", ".webm"]

# Convert all supported audio and video files in the input folder to MP3 using FFmpeg
for file_name in os.listdir(input_folder):
    # Check if the file has a supported extension
    if any(file_name.endswith(ext) for ext in supported_extensions):
        # Extract the file name and extension
        file_path = os.path.join(input_folder, file_name)
        
        print(f"IN: {file_path}")
        
        # filepath, ext = os.path.splitext(filename)
        file_name_without_ext = os.path.splitext(file_name)[0]
        # print(f"Without EXT: {file_name_without_ext}")
                
        # Set the output file name and path
        output_file = os.path.join(output_folder, f"{file_name_without_ext}.mp3")
        print(f"OUT: {output_file}")
        
        # Convert the audio file to MP3 using FFmpeg - VBR
        # os.system(f"ffmpeg -y -hide_banner -loglevel warning -i {file_path} -c:a libmp3lame -q:a 0 {output_file}")
        
        # CBR - 320kbps
        os.system(f"ffmpeg -y -hide_banner -loglevel warning -i \"{file_path}\" -vn -ar 44100 -ac 2 -b:a 320k \"{output_file}\"")

        print(f"Converted {file_path} to {output_file}")
        
        ### Strip the ID3 Tag ###
        if removeTags:
            print(f"Removing ID3 tags from {output_file}")
            # Open the MP3 file
            audio = File(output_file)

            # Remove all ID3 tags
            audio.clear()
            
            # Save the changes to the MP3 file
            audio.save()
        else:
            print(f"ID3 tags NOT removed from {output_file}")
            
        print(f"")

print("Conversion complete.")
