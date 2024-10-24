variable "aws_region" {
  description = "A região AWS onde os recursos serão criados"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket do S3"
  type        = string
}

variable "table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
}

variable "rekognition_role" {
  description = "Nome da função IAM para o Rekognition"
  type        = string
}
