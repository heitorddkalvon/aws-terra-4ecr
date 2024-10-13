output "s3_bucket" {
  value = aws_s3_bucket.navigation_images.bucket
}

output "lambda_function" {
  value = aws_lambda_function.image_processing.function_name
}