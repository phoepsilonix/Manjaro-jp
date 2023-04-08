#!/bin/bash

export HISTIGNORE="expect*";
export IGNORE_CC_MISMATCH=1
export LC_ALL=C
password=$(cat ~/.ssh/gpg-passphrase)

curdir=${PWD##*/}
exdir=$(cat /usr/lib/modules/${curdir}-MANJARO/version)
exdir=/usr/lib/modules/${exdir}/build
echo $exdir
gpg -dq ~/.ssh/pass.gpg | sudo -S pwd >/dev/null
sudo choom -n -1000 -p $$
sudo chown -R phoepsilonix:phoepsilonix $exdir
#for m in $(grep nvidia ../extramodules.txt)
for m in $(cat ../extramodules.txt)
do
        cd $m;
        cat ~/.ssh/gpg-passphrase|sudo -S pwd > /dev/null

[[ "$m" == "nvidia-390xx" ]] && sudo pacman -R nvidia-settings nvidia-utils --noconfirm && sync

expect -c "
  set timeout -1
  spawn makepkg -sCc
  expect {
        eof { exit 0 }
        -gl {\[sudo\] password for } {
                sleep 1
                send \"$password\r\"
                exp_continue
        }
        -re {\[[Yy]/[Nn]\]} {
                sleep 1
                send \"y\r\"
                exp_continue
        }
        -gl {Enter a number (default=1)} {
                sleep 1
                send \"\r\"
                exp_continue
        }
        exp_continue
  }
"

#        makepkg -sCc --noconfirm
        cd ..;
done

../../line-notify.sh "$curdir done"

exit 0

