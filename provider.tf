provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
  dynamic "assume_role" {
    for_each = var.environment == "dev" ? [1] : []
    content {
      role_arn = var.terraform_execution_role
    }
  }
}

provider "aws" {
  region = var.region
  dynamic "assume_role" {
    for_each = var.environment == "dev" ? [1] : []
    content {
      role_arn = var.terraform_execution_role
    }
  }
}

