resource "aws_dynamodb_table" "business_details" {
  name           = "BusinessDetails"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "businessId"

  attribute {
    name = "businessId"
    type = "S"
  }

  tags = {
    Name = "BusinessDetails"
  } 
}


resource "aws_dynamodb_table" "call_logs" {
  name           = "CallLogs"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "callId"

  attribute {
    name = "callId"
    type = "S"
  }

  tags = {
    Name = "CallLogs"
  }
}

resource "aws_dynamodb_table" "actions" {
  name           = "Actions"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "actionId"

  attribute {
    name = "actionId"
    type = "S"
  }

  tags = {
    Name = "Actions"
  }
}

