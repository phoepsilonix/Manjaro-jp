#!/bin/sh

gpg -d ~/.ssh/pass.gpg | sudo -S choom -n -1000 -p $$
pid=$(pgrep rqbit)
[[ -n "$pid" ]] && echo "kill" $pid && kill $pid && sleep 3
rm -rf ~/.local/share/session/*
rqbit server start ~/torrent/ &

dates=$(curl -s 'http://127.0.0.1:3030/torrents' | \
  jq -r '.[].[] | .name' | \
  grep -oE '[0-9]{6}' | \
  sort -n | \
  uniq)

count=$(echo "$dates" | wc -l)

if [ "$count" -gt 1 ]; then
  latest=$(echo "$dates" | tail -1)
  echo $latest

  curl -s 'http://127.0.0.1:3030/torrents' | \
  jq -r --arg latest "$latest" '.[].[] | select(.name | test("[0-9]{6}")) | select(.name | contains($latest) | not) | .info_hash' | \
  xargs -I{} curl -X POST "http://127.0.0.1:3030/torrents/{}/delete"
else
  echo "Only one unique date found ($dates), no files will be deleted."
fi
ls ~/torrent/*.torrent|xargs -I{} curl --data-binary "@/{}" 'http://127.0.0.1:3030/torrents?overwrite=true'
