# Déclaration des variables nécessaires
variable "name" {
  type        = string
  description = "The name of the API Gateway"
}

variable "function_arn" {
  type        = string
  description = "The ARN of the Lambda function to integrate with API Gateway"
}

variable "region" {
  type        = string
  description = "The AWS region"
  default     = "us-east-2"  # Si tu veux garder une valeur par défaut
}

# Création de l'API Gateway
resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = "API Gateway for ${var.name}"
}

# Création de la ressource de l'API Gateway
resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "resource"
}

# Création de la méthode GET pour la ressource de l'API Gateway
resource "aws_api_gateway_method" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "GET"
  authorization = "NONE"
}

# Intégration de la méthode avec Lambda via AWS_PROXY
resource "aws_api_gateway_integration" "this" {
  rest_api_id              = aws_api_gateway_rest_api.this.id
  resource_id              = aws_api_gateway_resource.this.id
  http_method              = aws_api_gateway_method.this.http_method
  type                     = "AWS_PROXY"
  integration_http_method  = "POST"
  uri                      = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.function_arn}/invocations"
}
