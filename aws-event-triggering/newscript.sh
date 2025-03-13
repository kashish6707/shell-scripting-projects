# Create a Lambda functioni
aws lambda create-function \
  --region "ap-south-1" \
  --function-name s3-lambda-function \
  --runtime "python3.8" \
  --handler "s3-lambda-function/s3-lambda-function.lambda_handler" \
  --memory-size 128 \
  --timeout 30 \
  --role "arn:aws:iam::$aws_account_id:role/$role_name" \
  --zip-file "fileb://./s3-lambda-function.zip"

# Add Permissions to S3 Bucket to invoke Lambda
aws lambda add-permission \
  --function-name "s3-lambda-function" \
  --statement-id "s3-lambda-sns" \
  --action "lambda:InvokeFunction" \
  --principal s3.amazonaws.com \
  --source-arn "arn:aws:s3:::kashish-ultimate-bucket"

# Create an S3 event trigger for the Lambda function
LambdaFunctionArn="arn:aws:lambda:ap-south-1:715841362546:function:s3-lambda-function"
aws s3api put-bucket-notification-configuration \
  --region "ap-south-1" \
  --bucket "kashish-ultimate-bucket" \
  --notification-configuration '{
    "LambdaFunctionConfigurations": [{
        "LambdaFunctionArn": "'"$LambdaFunctionArn"'",
        "Events": ["s3:ObjectCreated:*"]
    }]
}'

# Create an SNS topic and save the topic ARN to a variable
topic_arn=$(aws sns create-topic --name s3-lambda-sns --output json | jq -r '.TopicArn')

# Print the TopicArn
echo "SNS Topic ARN: $topic_arn"

# Trigger SNS Topic using Lambda Function


# Add SNS publish permission to the Lambda Function
aws sns subscribe \
  --topic-arn "$topic_arn" \
  --protocol email \
  --notification-endpoint "$email_address"

# Publish SNS
aws sns publish \
  --topic-arn "$topic_arn" \
  --subject "A new object created in s3 bucket" \
  --message "Hello from Abhishek.Veeramalla YouTube channel, Learn DevOps Zero to Hero for Free"
