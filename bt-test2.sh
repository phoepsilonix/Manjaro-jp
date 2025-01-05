#!/bin/sh

gpg -d ~/.ssh/pass.gpg | sudo -S choom -n -1000 -p $$
pid=$(pgrep rqbit)
[[ -n "$pid" ]] && echo "kill" $pid && kill $pid && sleep 3
rqbit server start ~/torrent/ &
sleep 1
rm ~/.local/share/session/*
ls ~/torrent/*.torrent|xargs -I{} curl --data-binary "@/{}" 'http://127.0.0.1:3030/torrents?overwrite=true'
