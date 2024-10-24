resource "aws_iam_role" "rekognition_role" {
  name = var.rekognition_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "rekognition.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "rekognition_policy" {
  name        = "RekognitionPolicy"
  description = "Política para Rekognition acessar S3 e DynamoDB"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "dynamodb:Query"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rekognition_attach" {
  role       = aws_iam_role.rekognition_role.name
  policy_arn = aws_iam_policy.rekognition_policy.arn
}
