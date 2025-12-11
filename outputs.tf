output "bucket_name" {
  description = "S3 Bucket Name (unique)"
  value       = aws_s3_bucket.my_bucket.bucket
}

output "website_endpoint" {
  description = "S3 Website Endpoint"
  value       = aws_s3_bucket.my_bucket.website_domain
}