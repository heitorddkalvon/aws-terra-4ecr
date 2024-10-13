import boto3
import os

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    rekognition = boto3.client('rekognition')

    # Pega o bucket e a chave do evento S3
    bucket = os.environ['S3_BUCKET']
    key = event['Records'][0]['s3']['object']['key']

    # Usa Rekognition para analisar a imagem
    response = rekognition.detect_labels(
        Image={'S3Object': {'Bucket': bucket, 'Name': key}},
        MaxLabels=10
    )

    # Retorna os labels detectados
    return response