# myalbum
Silly bash script for dl youtube full-albums and covert them in playable acurancy mode

This tool will download video file and convert into mp3 from youtube full albums OR album (*)playlists
(*)Note: please check consistency with the album referenced in playlists on youtube

## Tested system:
U(K|X|L)buntu 14.04, 16.04

## Prerequisites:
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install youtube-dl mp3splt libav-tools

## Installation, usage and sample dl:
```
~/$ git clone https://github.com/dentaku65/myalbum
~/$ cd myalbum/
~/myalbum$./myalbum.sh
```
## Once executed;
pass **mum** as artist
pass **finally** as album name 
pass **https://www.youtube.com/watch?v=chFmFpTc21s** as youtube link


You'll get this full album: múm - Finally We Are No One

