#! /bin/sh

P=$@
SOUND=/usr/share/sounds/freedesktop/stereo/phone-outgoing-calling.oga

echo $P
PID=$(pidof -x $P|sed 's/\([0-9]*\)/--pid=\0/g')
echo $PID

tail -f /dev/null $PID && (play -v3 $SOUND ; gnome-text-editor )

exit 0
