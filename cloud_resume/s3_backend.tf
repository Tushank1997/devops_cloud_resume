# Creating aws S3 backend bucket to maintain terraform state file

terraform {
   backend "s3" {
    region = "us-east-1"
    bucket = "tfstate-bucket-1.0"
    key = "terraform-backend.tfstate"
  }
}



