resource "aws_iam_role" "polly_role" {
  name = "PollyRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "polly.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "polly_policy" {
  name        = "PollyPolicy"
  description = "Política para permitir o uso do Amazon Polly"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "polly:SynthesizeSpeech"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "polly_attach" {
  role       = aws_iam_role.polly_role.name
  policy_arn = aws_iam_policy.polly_policy.arn
}