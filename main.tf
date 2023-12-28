data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = var.terraform_remote_state_s3_bucket 
    key    = var.terraform_remote_state_s3_bucket_key
    region = var.terraform_remote_state_s3_bucket_region
  }
}

# Retrieve EKS cluster configuration
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}


provider "kubernetes" {

  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {

    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    host                   = data.aws_eks_cluster.cluster.endpoint
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

# namespace for argocd

resource "kubernetes_namespace" "argo-ns" {
  metadata {
    name = "argocd"
  }
}

# release argocd
resource "helm_release" "argocd" {
  name       = "k10cd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"
}