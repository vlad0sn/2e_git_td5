# td5/scripts/tofu/modules/api-gateway/main.tf
resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = "API Gateway for ${var.name}"
}

resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "resource"
}

resource "aws_api_gateway_method" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  type        = "AWS_PROXY"
  integration_http_method = "POST"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.function_arn}/invocations"
}
