# Create S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "momna-terraform-bucket-87c08a5b"
  
  tags = {
    Name = "TerraformBucket"
  }
}

# Allow public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Public read bucket policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}

# Website configuration
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.my_bucket.id
  key          = "index.html"
  content_type = "text/html"
  
  content = "<html><body><h1>MOMNA NAWAZ. 230981</h1></body></html>"
}

# Upload error.html
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.my_bucket.id
  key          = "error.html"
  content_type = "text/html"
  
  content = "<html><body><h1>Oops! Page not found.</h1></body></html>"
}

# Optional output: website URL
output "website_url" {
  value = aws_s3_bucket.my_bucket.website_endpoint
  description = "The URL of the S3 static website"
}
