@echo off
title Cut / Download Youtube Videos
echo.
echo.
echo                          Cut 'n Download video from youtube
echo.
echo.
echo
echo            888        d8b        888   d8b                                  
echo            888        Y8P        888   Y8P                                  
echo            888                   888                                        
echo  8888b.    88888b.    888    .d88888   888   88888b.     .d8888b    .d88b.  
echo     "88b   888 "88b   888   d88" 888   888   888 "88b   d88P"      d88""88b 
echo  d888888   888  888   888   888  888   888   888  888   888        888  888 
echo 888  888   888 d88P   888   Y88b 888   888   888  888   Y88b.      Y88..88P 
echo "Y888888   88888P"    888    "Y88888   888   888  888    "Y8888P    "Y88P" 
echo.
echo.
rem get video url
echo.
echo Paste video's naked url. (without any parameter)
echo.
set /p videoUrl="Video Url: "

echo.
echo.

echo Available formats will be listed below this ..

echo.

timeout /t 3
rem list available formats
youtube-dl -s --list-formats --youtube-skip-dash-manifest %videoUrl%

echo.
echo.
echo.
echo.

rem let user to select video format
set /p selectedFormat="Select a format (22, 18, 36, ..): "

echo.
echo.

rem save video's json to a file called 'json'
youtube-dl -s --print-json %videoUrl% > json

rem parse the json to get directLink of desired video format
jq --arg f %selectedFormat% ".formats[] | select(.format_id == $f).url" json > directLink

echo.

rem get parameters for cut
set /p starts="Starts when (hh:mm:ss / ss.msms / ss): "
set /p duration="Duration (in seconds): "
set /p fileName="Give a name to the file: "

echo.

set /p directLink=<directLink

rem download cutted video as 'file_uncutted'
ffmpeg -ss %starts% -i %directLink% -t %duration% -c copy -avoid_negative_ts 1 %fileName%_uncutted.mp4

rem cut first 3 seconds of video, because ffmpeg's weird behavior
ffmpeg -i %fileName%_uncutted.mp4 -ss 00:00:3.000 %fileName%.mp4

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

echo DONE! Give it a big thumbs up and comment down below

echo.
echo.

rem delete unnecessary files
del json directLink %fileName%_uncutted.mp4

pause