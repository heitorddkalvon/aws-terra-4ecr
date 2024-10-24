resource "aws_s3_bucket" "storage_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "S3BucketForVisionApp"
    Environment = "dev"
  }
}