#!/bin/bash

export HISTIGNORE="expect*";
export IGNORE_CC_MISMATCH=1
export LC_ALL=C
password=$(cat ~/.ssh/gpg-passphrase)

curdir=${PWD##*/}
exdir=$(cat /usr/lib/modules/${curdir}-MANJARO/version)
exdir=/usr/lib/modules/${exdir}/build
echo $exdir
sudo -S pwd < ~/.ssh/gpg-passphrase >/dev/null
sudo chown -R phoepsilonix:phoepsilonix $exdir
#for m in $(grep nvidia ../extramodules.txt)
for m in $(cat ../extramodules.txt)
do
        cd $m;
#        cat ~/.ssh/gpg-passphrase|sudo -S pwd > /dev/null
expect -c "
  set timeout -1
  spawn makepkg -sCc
  expect {
        eof { exit 0 }
        -gl {\[sudo\] password for } {
                send -- \"$password\r\"
                sleep 1
                exp_continue
        }
        -re {\[[Yy]/[Nn]\]} {
                send \"y\r\"
                sleep 1
                exp_continue
        }
        -gl {Enter a number (default=1)} {
                send \"\r\"
                sleep 1
                exp_continue
        }
        sleep 1
        exp_continue
  }
"

#        makepkg -sCc --noconfirm
        cd ..;
done
 
exit 0

