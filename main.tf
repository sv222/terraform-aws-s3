resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "private"
  region = var.region

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    id     = "default-rule"
    status = "Enabled"
    prefix = ""
    tags   = {}

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule

    content {
      id     = lifecycle_rule.value["id"]
      status = lifecycle_rule.value["status"]
      prefix = lifecycle_rule.value["prefix"]
      tags   = lifecycle_rule.value["tags"]

      dynamic "transition" {
        for_each = lifecycle_rule.value["transition"]

        content {
          days          = transition.value["days"]
          storage_class = transition.value["storage_class"]
        }
      }

      dynamic "expiration" {
        for_each = lifecycle_rule.value["expiration"]

        content {
          days = expiration.value["days"]
        }
      }
    }
  }
}

