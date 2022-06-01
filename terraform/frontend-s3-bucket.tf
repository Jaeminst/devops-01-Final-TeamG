resource "aws_s3_bucket" "front" {
  bucket_prefix = "front"
}
resource "aws_s3_bucket_accelerate_configuration" "front" {
  bucket = aws_s3_bucket.front.id
  status = "Enabled"
}

resource "aws_s3_bucket_acl" "front" {
  bucket = aws_s3_bucket.front.id
  acl = "public-read"
}

# data "aws_canonical_user_id" "current" {}

# resource "aws_s3_bucket_acl" "front" {
#   bucket = aws_s3_bucket.front.id
#   access_control_policy {
#     grant {
#       grantee {
#         id   = data.aws_canonical_user_id.current.id
#         type = "CanonicalUser"
#       }
#       permission = "FULL_CONTROL"
#     }

#     owner {
#       id = data.aws_canonical_user_id.current.id
#     }
#   }
# }

resource "aws_s3_bucket_policy" "front" {
  bucket = aws_s3_bucket.front.id
  policy = data.aws_iam_policy_document.front.json
}

data "aws_iam_policy_document" "front" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.front.arn,
      "${aws_s3_bucket.front.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_cors_configuration" "front" {
  bucket = aws_s3_bucket.front.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_public_access_block" "front" {
  bucket = aws_s3_bucket.front.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "front" {
  bucket = aws_s3_bucket.front.id
  redirect_all_requests_to {
    host_name = "www.jaemin.click"
    protocol  = "https"
  }

  # index_document {
  #   suffix = "index.html"
  # }

  # error_document {
  #   key = "error.html"
  # }

  # routing_rule {
  #   condition {
  #     key_prefix_equals = "docs/"
  #   }
  #   redirect {
  #     replace_key_prefix_with = "documents/"
  #   }
  # }
}