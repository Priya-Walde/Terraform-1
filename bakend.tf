terraform {
  backend "s3" {
    bucket = "tf-backend-bucket-3"
    key = "terraform.tfstate"
    region = "us-east-1"
    profile = "priya"
  }
}
