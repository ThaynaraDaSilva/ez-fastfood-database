variable "region" {
  default = "us-east-1"
}


variable "environment" {
  default = "dev"
}

variable "project" {
  default = "ezfastfood"
}

variable "api_name" {
  default = "ez-fast-food-api"
}

resource "aws_apigatewayv2_authorizer" "jwt_authorizer" {
  api_id = aws_apigatewayv2_api.http_api.id
  name   = "jwt-authorizer-${environment}-${region}-${project}"

  authorizer_type = "REQUEST"
  authorizer_uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.jwt_auth_lambda.arn}/invocations"

  identity_sources = ["$request.header.Authorization"]

  authorizer_payload_format_version = "2.0"
}

