terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}

resource "random_id" "bucket_suffix" {
  byte_length = 2
}

resource "aws_s3_bucket" "shiva-sangwan" {
  bucket = "shiva-sangwan-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "shiva-sangwan" {
  bucket = aws_s3_bucket.shiva-sangwan.id

  block_public_acls       = false
  block_public_policy      = false
  ignore_public_acls       = false
  restrict_public_buckets   = false
}

resource "aws_s3_bucket_website_configuration" "shiva-sangwan" {
  bucket = aws_s3_bucket.shiva-sangwan.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.shiva-sangwan.bucket
  source = "./index.html"
  key    = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style" {
  bucket = aws_s3_bucket.shiva-sangwan.bucket
  key    = "styles.css"
  source = "./styles.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_policy" "shiva-sangwan" {
  bucket = aws_s3_bucket.shiva-sangwan.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.shiva-sangwan.arn}/*"
      },
    ]
  })
}
