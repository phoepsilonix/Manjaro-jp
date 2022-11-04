#!/bin/sh
#set -eux
# sample of keychain
# not using gpg-agent,ssh-agent,pinentry-gnome
#

export HISTIGNORE="expect*";
# ssh store key remove clear delete
echo "removing ssh store keys,Identities"
#
#ssh-add -D
keychain --clear

# pkill ssh-agent 
keychain -k mine
# if pkill all ssh-agent process
# keychain -k all

# display ssh store key
ssh-add -l 
keychain -l

# if gpg-agent ssh enable
# delete key gpg-agent store ssh keys
keys=$(gpg-connect-agent 'KEYINFO --ssh-list --ssh-fpr --with-ssh' /bye | awk '{print $3}' | head -n -1)
echo "GPG ssh enable keys:"
echo $keys
echo "deleting"
for key in $keys; do gpg-connect-agent "delete_key $key" /bye; done

# gnome-keyring-daemon pinentry-gnome
#
echo
echo "if using seahorse, gnome-keyring-daemon, and if passphrase is stored, stored file is here." 
echo "~/.local/share/keyrings/"
ls -l ~/.local/share/keyrings/
# rm ~/.local/share/keyrings/*

# confirm
echo "SSH_AUTH_SOCK" $SSH_AUTH_SOCK
ls -l $SSH_AUTH_SOCK
echo "unset SSH_AUTH_SOCK"
unset SSH_AUTH_SOCK

# then all ssh store keys is disable
echo "####################################"
echo "this is sample of using keychain and expect"
echo "####################################"
echo

#################################
# sample of using keychain 
#
# ssh password file
password=$(cat ~/.ssh/pass)

expect << EOF
  spawn keychain --agents ssh --eval id_ed25519
  expect "* passphrase *:" {
        stty -echo
        send "$password\r"
        stty echo
  }
  expect eof
EOF

eval `keychain --agents ssh --eval id_ed25519`
ls -l $SSH_AUTH_SOCK
# then this script only keychain enable

# test command,git,rsync,ssh and so on
echo "test command"
echo "git pull"
git pull

# end of keychain enable 
#
#ssh-add -D
keychain --clear

# kill ssh-agent 
keychain -k mine
#############################################

# confirm
# display ssh store key
echo "ssh-add -l, keychain -l"
ssh-add -l
keychain -l

echo "keychain -k mine:kill my ssh-agent process."
keychain -k mine

# confirm
echo "confirm"
echo "SSH_AUTH_SOCK" $SSH_AUTH_SOCK
ls -l $SSH_AUTH_SOCK
echo "unset SSH_AUTH_SOCK"
unset SSH_AUTH_SOCK

exit 0;

