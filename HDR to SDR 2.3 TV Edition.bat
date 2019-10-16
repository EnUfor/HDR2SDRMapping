@echo off
title Tonemap HDR to SDR 1080p
echo Tonemap HDR to SDR 1080p
echo ************************
set width2=1920
set ffmpeglocation="%~dp0ffmpeg.exe"

:again
if "%~1" == "" goto done

set str=%~n1

set "first=%str: 2160p=" & set "last=%"

set input="%~dp1%~n1%.mkv"
set output="%~dp1%first% 1080p x264 2.0 AC3.mkv"

echo input:  %input%
echo output: %output%


timeout 8
%ffmpeglocation% -i %input% -vf scale=%width2%:-1,zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 22 -c:a ac3 -ac 2 %output%

shift
goto again

:done
pause
exit