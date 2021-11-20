import urllib3
import json

def lambda_handler(event, context):
    http = urllib3.PoolManager()
    url = 'https://www.workmotion.com/'
    req = http.request('GET', url)

    return {
        "statusCode": req.status,
        "headers": json.dumps({
            "Content-Type": "application/json"
        }),
        "body": json.dumps({
            "body ": req.data.decode('utf-8')
        })
    }