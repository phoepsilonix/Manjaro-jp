#! /bin/sh

P="$@"
token="$(cat ~/.ssh/.line-token)"
#url="https://api.line.me/v2/bot/message/broadcast"
url="https://api.line.me/v2/bot/message/push"
user="$(cat ~/.ssh/.line-user)"
MSG=$(cat <<EOF
{
     "to": "${user}",
	 "messages": [
        {
            "type":"text",
            "text":"${P}"
        }
    ]
}
EOF
)
echo $MSG
#curl -v -X POST $url \
#-H 'Content-Type: application/json' \
curl -H "Authorization: Bearer $token" $url --json @- <<HERE
{
     "to": "${user}",
	 "messages": [
        {
            "type":"text",
            "text":"${P}"
        }
    ]
}
HERE
#-d "$MSG"
exit 0

#-H 'X-Line-Retry-Key: {UUID}' \
