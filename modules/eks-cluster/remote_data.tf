data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "your-bucket"
    key    = "terraform-tfstate/vpc.tfstate"
    region = "us-east-1"
  }
}