locals {
  argo          = "../../../k8s/helm/chart/addons/argo/argo-cd"
  argo_resource = "../../../k8s/helm/chart/addons/argo/argo-resources"

}

resource "helm_release" "argo" {
  name      = "argo"
  namespace = "argocd"
  chart     = local.argo


  create_namespace = true

  dependency_update = true

  values = [
    "${file("${local.argo}/values.yaml")}"
  ]

  lifecycle {
    ignore_changes = [
      values
    ]
  }

}


resource "helm_release" "argo-resource" {
  name      = "argo-release"
  chart     = local.argo_resource
  namespace = "argocd"

  create_namespace = true

  dependency_update = true

  depends_on = [
    helm_release.argo
  ]

  values = [
    "${file("${local.argo_resource}/values.yaml")}"
  ]

  lifecycle {
    ignore_changes = [
      values
    ]
  }

}