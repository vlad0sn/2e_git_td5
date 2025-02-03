terraform {
  backend "s3" {
    # TODO: fill in your own bucket name here!
    bucket         = "fundamentals-of-td5" 
    key            = "ch5/tofu/live/lambda-sample"       
    region         = "us-east-2"
    encrypt        = true
    # TODO: fill in your own DynamoDB table name here!
    dynamodb_table = "fundamentals-of-table-td5" 
  }
}