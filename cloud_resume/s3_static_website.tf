
#generate random number to append in S3 bucket name for uniqueness.

resource "random_id" "random_number" {
  byte_length = 4
}

# Creating aws S3 bucket

resource "aws_s3_bucket" "web_s3_bucket" {
  bucket = "${var.web_domain_name}-${random_id.random_number.hex}"
}

# Uploading src folder files into the bucket

resource "aws_s3_object" "html_file" {
  bucket       = aws_s3_bucket.web_s3_bucket.bucket
  key          = "index.html"
  source       = "${path.module}/src/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "css_file" {
  bucket       = aws_s3_bucket.web_s3_bucket.bucket
  key          = "style.css"
  source       = "${path.module}/src/style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "image_file" {
  bucket = aws_s3_bucket.web_s3_bucket.bucket
  key    = "background.jpg"
  source = "${path.module}/src/background.jpg"
}


#Making bucket publicly accessible

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.web_s3_bucket.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#Updating bucket policy for access from another sources

resource "aws_s3_bucket_policy" "public_bucket_access_policy" {
  bucket = aws_s3_bucket.web_s3_bucket.bucket
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Action    = "s3:GetObject",
          Effect    = "Allow",
          Resource  = "arn:aws:s3:::${aws_s3_bucket.web_s3_bucket.bucket}/*",
          Principal = "*"
        }
      ]
    }
  )
}

#Enabling S3 static website hosting

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.web_s3_bucket.bucket

  index_document {
    suffix = "index.html"
  }
}


# resource "aws_s3_object" "bucket_files" {

#   //fileset() function used to input list of files from the folder to for_each loop
#   for_each = fileset("${path.module}/src", "*")

#   bucket = aws_s3_bucket.web_s3_bucket.bucket
#   key    = each.value
#   source = "${path.module}/src/${each.value}"
# }