import os, sys
from slack_sdk import WebClient


slack_token = 'xoxb-20081664100-4681483384818-MHFfFCpBC85LnAjgR56upoVJ'



client = WebClient(token=slack_token)

message=sys.argv[1]

client.chat_postMessage(channel='#testing111',text=message)