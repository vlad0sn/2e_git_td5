provider "aws" {
  region = "us-east-2"
}

module "state" {
  source = "git::https://github.com/vlad0sn/2e_git_td5.git//td5/scripts/tofu/modules/state-bucket"

  # TODO: fill in your own bucket name!
  name = "fundamentals-of-td5"
}