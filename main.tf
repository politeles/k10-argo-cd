provider "kubernetes" {

  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_cert_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {

    cluster_ca_certificate = base64decode(var.cluster_cert_data)
    host                   = var.cluster_endpoint
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
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