import os, sys
from slack_sdk import WebClient


slack_token = 'xoxb-20081664100-4114756072293-g7Q9F693LPr2ubhOBqeRLLkO'



client = WebClient(token=slack_token)

message=sys.argv[1]

client.chat_postMessage(channel='#testing111',text=message)
