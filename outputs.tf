output "s3_bucket_name" {
  value = aws_s3_bucket.storage_bucket.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.vision_table.name
}

output "rekognition_role" {
  value = aws_iam_role.rekognition_role.name
}

output "polly_role" {
  value = aws_iam_role.polly_role.name
}