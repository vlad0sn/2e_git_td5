provider "aws" {
  region = "us-east-2"
}

module "function" {
  source = "github.com/brikis98/devops-book//ch3/tofu/modules/lambda"

  name = var.name

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
  source = "git::https://github.com/vlad0sn/2e_git_td5.git//td5/scripts/tofu/modules/api-gateway"

  name = var.name
  function_arn       = module.function.function_arn
  api_gateway_routes = ["GET /"]
}
