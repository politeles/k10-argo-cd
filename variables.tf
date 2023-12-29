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