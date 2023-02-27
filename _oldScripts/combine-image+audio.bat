@echo off

set AUDIO=audio.wav
set IMAGE=coperta.png
set OUT=idei_atipice_45.mp4

ffmpeg -loop 1 -i %IMAGE% -i %AUDIO% -c:v libx264 -tune stillimage -c:a aac -b:a 320k -vf "scale='iw-mod(iw,2)':'ih-mod(ih,2)',format=yuv420p" -shortest -movflags +faststart %OUT%

rem ffmpeg -loop 1 -i coperta1.png -i audio_mixdown.wav -c:v libx264 -tune stillimage -c:a aac -b:a 320k -vf "scale='iw-mod(iw,2)':'ih-mod(ih,2)',format=yuv420p" -shortest -movflags +faststart idei_atipice_45.mp4

pause