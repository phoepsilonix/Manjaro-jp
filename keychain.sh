#!/bin/bash

gpg_passphrase=~/.ssh/gpg-passphrase
ssh_passphrase=~/.ssh/ssh-passphrase.gpg

####### expectによる、履歴を残さない
export HISTIGNORE="expect*";

function call_keychain()
{

###### expectによる、履歴を残さない
export HISTIGNORE="expect*";

gpg_pass=~/.ssh/gpg-passphrase
ssh_pass=~/.ssh/ssh-passphrase.gpg
###### スクリプト終了時には、keychainをクリアして、ssh-agentを停止する。
trap "
keychain -k mine
keychain --clear
" EXIT

###### sshのパスフレーズを復号化する
PASSPHRASE=$(gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -dq $ssh_pass)
KEY_FILENAME=$1

#spawn ssh-add $HOME/.ssh/$KEY_FILENAME
#spawn keychain --agents ssh --eval $KEY_FILENAME

###### expectでパスフレーズ入力を自動化
expect <<EOF
  spawn keychain --agents ssh --eval $KEY_FILENAME
  expect {
    "* passphrase *:" {
      send "$PASSPHRASE\r"
      exp_continue
    }
  "denied" { exit 1 }
  eof { exit 0 }
}
EOF
eval `keychain --eval $KEY_FILENAME 2>/dev/null`
}

call_keychain id_ed25519_3
call_keychain id_ed25519-2
call_keychain id_aur
call_keychain id_ed25519

###### このスクリプト内で、有効化させる。
