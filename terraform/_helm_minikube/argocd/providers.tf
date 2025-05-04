provider "kubernetes" {
  config_path    = "C:/Users/uddes/.kube/config"
  config_context = "minikube"
}


terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}


provider "helm" {
  kubernetes {
    config_path = "C:/Users/uddes/.kube/config"
  }
}