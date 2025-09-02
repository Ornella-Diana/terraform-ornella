provider "aws" {
  region = "us-east-1"  
}

resource "aws_s3_bucket" "terra_bucket" {
  bucket = "terra-buck-ornella-s1"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "terra-buck-ornella-s1"
    Environment = "dev"
  }
}
