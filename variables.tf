variable "aws_region" {
  description = "AWS region ID for deployment (e.g. eu-west-1)"
  type        = string
  default     = "eu-west-1"
}

variable "terraform_remote_state_s3_bucket"{
    type = string
}

variable "terraform_remote_state_s3_bucket_key"{
    type = string
}

variable "terraform_remote_state_s3_bucket_region"{
    type = string
}