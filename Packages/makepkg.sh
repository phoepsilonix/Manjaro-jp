#!/bin/bash

export HISTIGNORE="expect*";
export IGNORE_CC_MISMATCH=1
export LC_ALL=C
password=$(cat ~/.ssh/gpg-passphrase)

curdir=${PWD##*/}
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
                exp_continue
        }
        -re {\[[Yy]/[Nn]\]} {
                send \"y\r\"
                exp_continue
        }
        exp_continue
  }
"
#        makepkg -sCc --noconfirm
        cd ..;
done
 
exit 0

