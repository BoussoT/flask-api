terraform {
  backend "s3" {
    bucket         = "mon-bucket-terraformflask1"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true

  }
}
