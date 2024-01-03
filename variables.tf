variable "region" {
  description = "The region in which to create the EKS cluster"
  type        = string
}

variable "bucket" {
  description = "The name of the S3 bucket used for storing Terraform state"
  type        = string
}

variable "key" {
  description = "The name of the S3 key used for storing Terraform state"
  type        = string
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_cert_data" {
  description = "The certificate-authority-data for the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  type        = string
}