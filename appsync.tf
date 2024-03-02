resource "aws_iam_role" "appsync_dynamodb_role" {
  name = "appsync-dynamodb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "appsync.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "appsync_dynamodb_attach" {
  role       = aws_iam_role.appsync_dynamodb_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}



resource "aws_appsync_graphql_api" "update_business_details" {
  name                = "business_details"
  authentication_type = "API_KEY"
  schema              = file("schema.graphql")
}

resource "aws_appsync_datasource" "dynamodb_business_details" {
  api_id = aws_appsync_graphql_api.update_business_details.id
  name   = "dynamodbBusinessDetailsDataSource"
  type   = "AMAZON_DYNAMODB"

  service_role_arn = aws_iam_role.appsync_dynamodb_role.arn

  dynamodb_config {
    table_name             = aws_dynamodb_table.business_details.name
    use_caller_credentials = false
  }
}

resource "aws_appsync_resolver" "update_business_details_resolver" {
  api_id = aws_appsync_graphql_api.update_business_details.id
  type   = "Mutation"
  field  = "updateBusinessDetails"

  data_source = aws_appsync_datasource.dynamodb_business_details.name

  request_template  = file("resolvers/update_business_details_request.vtl")
  response_template = file("resolvers/update_business_details_response.vtl")
}

resource "aws_appsync_resolver" "create_business_details_resolver" {
  api_id = aws_appsync_graphql_api.update_business_details.id
  type   = "Mutation"
  field  = "createBusinessDetails"

  data_source = aws_appsync_datasource.dynamodb_business_details.name

  request_template  = file("resolvers/create_business_details_request.vtl")
  response_template = file("resolvers/create_business_details_response.vtl")
}

