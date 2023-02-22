variable "aws_region" {
  description = "The AWS region to use"
  default     = "us-east-1"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to create."
}

variable "region" {
  type        = string
  description = "The region in which to create the S3 bucket."
}

variable "versioning" {
  type        = bool
  description = "Whether versioning should be enabled for the S3 bucket."
  default     = true
}

variable "lifecycle_rule" {
  type        = map(string)
  description = "A map of S3 object lifecycle rules."
  default     = {}
}