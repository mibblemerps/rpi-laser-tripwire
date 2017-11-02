@echo off
ffmpeg -i "%1" -acodec libvorbis "%2"