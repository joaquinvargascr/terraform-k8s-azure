resource "helm_release" "nginx-ingress" {
  name             = "${var.aks_name}-nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true

  set {
    name  = "controller.replicaCount"
    value = 2
  }
}

# resource "helm_release" "cert-manager" {
#   name             = "${var.aks_name}-cert-manager"
#   repository       = "https://charts.jetstack.io"
#   chart            = "cert-manager"
#   namespace        = "cert-manager"
#   create_namespace = true

#   set {
#     name  = "installCRDs"
#     value = true
#   }
# }

