#!/bin/bash

# sudo add-apt-repository ppa:nilarimogard/webupd8
# sudo apt-get update
# sudo apt-get install youtube-dl mp3splt libav-tools
#
# Works only with youtube-dl of ppa:nilarimogard/webupd8
#
# This tool will download video file and convert into mp3 from youtube full albums OR album playlists
# Note on album playlist: please check consistency for the album reference in playlists on youtube
#
# Once executed, example: pass "mum" as artist, pass "finally" as album name, pass https://www.youtube.com/watch?v=chFmFpTc21s as youtube link
# You'll get this full album: múm - Finally We Are No One
#

spinner()
{
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}


musicxdg=$(cat /etc/xdg/user-dirs.defaults | grep '^\MUSIC=' | cut -c 7-)
fa=$(echo Full_Albums_dl_$HOSTNAME)
dt=$(date +%N)
dl=$(mkdir /tmp/$dt)

cd /tmp/$dt; \

clear
echo "" 
echo -e "\e[93m Please enter Artist name: "
echo -e "\e[92m"
read artist 

echo "" 
echo -e "\e[93m Please enter album name (can be partial name of album): "
echo -e "\e[92m"
read album 

echo "" 
echo -e "\e[93m Please enter youtube link: "
echo -e "\e[92m"
read link 

id=$(youtube-dl -s --get-id $link)
full=$(youtube-dl -s -e $link)
aut=$(youtube-dl -s -A $link)

echo -e "\e[93m"
echo -e "\e[37m Dowloading and converting: \e[92m$full \e[37m\n [Around 5-10 minutes for a single album] Please wait... \e[91m"
youtube-dl -q -o '%(autonumber)s.%(ext)s' -x --audio-format mp3 --audio-quality 0 $link & spinner


cat *.mp3 >out.mp3

echo "" 
echo -e "\e[37m Search for (Artist, album or both): \e[92m$full"
echo -e "\e[93m"
mp3splt -q -a -f -c query{"$artist $album"} -d $HOME/$musicxdg/$fa/ -o @a/@b/@a_@n_@t "out.mp3"

stored=$(find $HOME/$musicxdg/$fa/ -type d -print0 | xargs -0 -r ls -dt | head -1)
echo ""
echo -e "\e[92m $full \e[37m\n Ready here: \e[92m\n $stored"
echo -e "\e[91m\e[1m"
read -p " Delete bigger mp3 file [Y/n]? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -R "/tmp/$dt"
fi
echo -e "\e[39m"



