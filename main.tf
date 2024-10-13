provider "aws" {
  region = "us-east-1"  # Defina a região correta
}

# Criar um bucket S3 para armazenar imagens
resource "aws_s3_bucket" "navigation_images" {
  bucket = "navigation-images-bucket"
  acl    = "private"
}

# Criar uma função Lambda para processamento de imagens
resource "aws_lambda_function" "image_processing" {
  function_name = "process_images"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"  # Defina a runtime

  # Código da Lambda
  filename      = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.navigation_images.bucket
    }
  }
}

# Definir as permissões para a Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Permissões de execução
resource "aws_iam_role_policy" "lambda_exec_policy" {
  role   = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = aws_s3_bucket.navigation_images.arn
      }
    ]
  })
}

# Serviço Polly para conversão de texto para voz
resource "aws_polly_synthesis_task" "voice_task" {
  output_format = "mp3"
  text          = "This is a voice command for the user"
  voice_id      = "Joanna"
  output_s3_bucket_name = aws_s3_bucket.navigation_images.bucket
}
