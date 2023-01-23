import os, sys
from slack_sdk import WebClient

secret='vmv`+0..6/442/..+246/2611626/6+.r/7VJee3ppLJDcuO3HrTFqg'
new=''
for s in secret:
    new+=chr(ord(s)+2)
client = WebClient(token=new)

message=sys.argv[1]

client.chat_postMessage(channel='#testing111',text=message)