provider "aws" {
  region = var.region
}



# 
# Create EC2 instance
resource "aws_instance" "terra_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.terra_keypair.key_name

  tags = {
    Name = var.instance_name
  }
}


# Generate random string for bucket suffix
resource "random_id" "randomness" {
  byte_length = 10
}

# Local variable for naming convention
locals {
  bucket_name = "terra-ornella-${random_id.randomness.hex}"
}

# Create the S3 bucket
resource "aws_s3_bucket" "terra_bucket" {
  bucket = local.bucket_name

  tags = {
    Name        = local.bucket_name
    Environment = "dev"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "terra_bucket_versioning" {
  bucket = aws_s3_bucket.terra_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}



