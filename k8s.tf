resource "kubernetes_namespace" "ns" {
  metadata {
    name = var.ns_name
  }
}

resource "kubernetes_pod" "nginx" {
  metadata {
    name      = "${var.aks_name}-nginx"
    namespace = kubernetes_namespace.ns.metadata.0.name
    labels = {
      app = "${var.aks_name}-nginx"
    }
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "${var.aks_name}-nginx"
      port {
        container_port = 80
      }
    }
  }
}

resource "kubernetes_service" "nginx-svc" {
  metadata {
    name      = "${var.aks_name}-nginx-svc"
    namespace = kubernetes_namespace.ns.metadata.0.name
  }

  spec {
    selector = {
      app = kubernetes_pod.nginx.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

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

resource "helm_release" "cert-manager" {
  name             = "${var.aks_name}-cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = true
  }
}