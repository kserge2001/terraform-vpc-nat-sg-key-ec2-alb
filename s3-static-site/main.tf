resource "aws_s3_bucket" "bucket1" {
  bucket = var.bucketname
}
resource "aws_s3_bucket_ownership_controls" "own1" {
  bucket = aws_s3_bucket.bucket1.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "acl" {
  bucket = aws_s3_bucket.bucket1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.own1,
    aws_s3_bucket_public_access_block.acl,
  ]

  bucket = aws_s3_bucket.bucket1.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket1.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.bucket1.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
  depends_on = [ aws_s3_bucket_acl.example ]
}
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.bucket1.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
  depends_on = [ aws_s3_bucket_acl.example ]
}

resource "aws_s3_object" "portfolio" {
  bucket = aws_s3_bucket.bucket1.id
  key = "Motivation.jpg"
  source = "Motivation.jpg"
  acl = "public-read"
  depends_on = [ aws_s3_bucket_acl.example ]
}
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.bucket1.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [ aws_s3_bucket_acl.example ]
}

output "bucket-link" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
  
}