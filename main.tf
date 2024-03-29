terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.39.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "random_string" "random_name" {
  length           = 16
  special          = false
  lower            = true
  upper            = false
  override_special = "/@£$"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.tf_backend}-${random_string.random_name.id}"
  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.default_tags
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.tf_backend}-${random_string.random_name.id}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.default_tags
}
