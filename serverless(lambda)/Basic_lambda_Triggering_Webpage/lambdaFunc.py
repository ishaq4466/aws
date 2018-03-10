#Just paste this python script inside the LambdaFunction
def lambda_handler(event, context):
    print("In lambda handler")
    
    resp = {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": "*",
        },
        "body": "You have Triggered Lambda function 1!"
    }
    
    return resp
