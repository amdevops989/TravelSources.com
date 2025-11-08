aws s3 mb s3://travelsources-tfstate --region us-east-1 --profile devops-am

aws dynamodb create-table \
  --table-name travelsources-tf-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1 \
  --profile devops-am
