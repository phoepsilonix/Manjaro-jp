#! /bin/sh

P=$@
PID=$(pidof -x $P|sed 's/\([0-9]*\)/--pid=\0/g')
echo $P "is waiting.." $PID

tail -f /dev/null $PID

exit 0
