provider "aws" {
  region = "us-east-2"
}

module "function" {
  source = "git::https://github.com/brikis98/devops-book.git//ch3/tofu/modules/lambda"
  name   = var.name

  src_dir = "${path.module}/src"
  runtime = "nodejs20.x"
  handler = "index.handler"

  memory_size = 128
  timeout     = 5

  environment_variables = {
    NODE_ENV = "production"
  }
}


module "gateway" {
  source = "git::https://github.com/vlad0sn/2e_git_td5.git//td5/scripts/tofu/modules/api-gateway?ref=opentofu-tests"

  name              = var.name
  function_arn      = module.function.function_arn
  region           = "us-east-2"
}
# Ajouter l'output pour récupérer l'api_endpoint
output "api_endpoint" {
  value = module.gateway.api_endpoint
  description = "The endpoint URL of the API Gateway"
}
