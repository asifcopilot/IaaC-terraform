provider "aws" {
  region = "us-east-2"
}

# terraform {
#   backend "s3" {
#     bucket = "tf-state-s3-demo"
#     key    = "state.tfstate"
#     region = "us-east-2"
#   }
# }