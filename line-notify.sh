#! /bin/sh

P=$@
SOUND=/usr/share/sounds/freedesktop/stereo/phone-outgoing-calling.oga

PID=$(pidof -x $P|sed 's/\([0-9]*\)/--pid=\0/g')
echo $P $PID
token=$(cat ~/.ssh/line-token)

tail -f /dev/null $PID && \
        curl -X POST -H "Authorization: Bearer $token" -F message="$P done" https://notify-api.line.me/api/notify || \
        curl -X POST -H "Authorization: Bearer $token" -F message="$P error" https://notify-api.line.me/api/notify

echo
exit 0

