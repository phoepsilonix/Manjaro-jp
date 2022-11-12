#!/bin/bash

gpg_passphrase=~/.ssh/gpg-passphrase
ssh_passphrase=~/.ssh/ssh-passphrase.gpg

####### expectによる、履歴を残さない
export HISTIGNORE="expect*";

###### スクリプト終了時には、keychainをクリアして、ssh-agentを停止する。
trap "
keychain --clear
keychain -k mine
" EXIT

###### sshのパスフレーズを復号化する
PASSPHRASE=$(gpg --passphrase-file $gpg_passphrase --batch --pinentry-mode=loopback -dq $ssh_passphrase)

###### expectでパスフレーズ入力を自動化
expect << EOF
  spawn keychain --agents ssh --eval id_ed25519
  expect "* passphrase *:" {
        send "$PASSPHRASE\r"
  }
  expect {
    "denied" { exit 1 }
    eof { exit 0 }
  }
EOF

###### このスクリプト内で、有効化させる。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`

