@echo off
echo Tonemap HDR to SDR 1080p
echo ************************
set width2=1920

"%~dp0MediaInfo.exe" %1 --dump-info=output.txt

for /f "tokens=2 delims=:" %%x in ('find "Width" output.txt') do set width=%%x
for /f "tokens=2 delims=:" %%x in ('find "Height" output.txt') do set height=%%x
del output.txt

set width=%width: =%
set width=%width:~0,-6%
set height=%height: =%
set height=%height:~0,-6%
echo Input: %width% x %height% (HDR)
set /a height2=(height*1920)/width
echo Output: %width2% x %height2% (SDR)


set str=%~n1
for /f "tokens=1 delims=)" %%a in ("%str%") do set str=%%a
set str=%str%) 1080p x264 AVC 2.0 AC3
echo "%~dp1%str%.mkv"

pause
"%~dp0ffmpeg.exe" -i %1 -vf scale=%width2%:%height2%,zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 22 -c:a ac3 -ac 2 "%~dp1%str%.mkv"
pause