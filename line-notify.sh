#! /bin/sh

P=$@
token=$(cat ~/.ssh/line-token)

curl -X POST -H "Authorization: Bearer $token" -F message="$P" https://notify-api.line.me/api/notify

exit 0

