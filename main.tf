module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = var.table_name
}

module "rekognition" {
  source      = "./modules/rekognition"
  rekognition_role = var.rekognition_role
}

module "polly" {
  source      = "./modules/polly"
}