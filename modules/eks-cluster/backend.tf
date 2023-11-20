terraform {
  backend "s3" {
    bucket  = "your-bucket"
    key     = "terraform-tfstate/eks-cluster.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
