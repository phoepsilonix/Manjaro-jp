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
curl -v -X POST $url \
-H 'Content-Type: application/json' \
-H "Authorization: Bearer $token" \
-d "$MSG"
exit 0

#-H 'X-Line-Retry-Key: {UUID}' \
