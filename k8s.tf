resource "kubernetes_namespace" "ns" {
  metadata {
    name = var.ns_name
  }
}

resource "kubernetes_deployment" "app-echo" {
  metadata {
    name      = "${var.aks_name}-app-echo"
    namespace = kubernetes_namespace.ns.metadata[0].name
    labels = {
      app = "${var.aks_name}-app-echo"
    }
  }
  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "${var.aks_name}-app-echo"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.aks_name}-app-echo"
        }
      }
      spec {
        container {
          image = "ealen/echo-server:latest"
          name  = "${var.aks_name}-app-echo"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "app-apache" {
  metadata {
    name      = "${var.aks_name}-app-apache"
    namespace = kubernetes_namespace.ns.metadata[0].name
    labels = {
      app = "${var.aks_name}-app-apache"
    }
  }
  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "${var.aks_name}-app-apache"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.aks_name}-app-apache"
        }
      }
      spec {
        container {
          image = "httpd:2.4"
          name  = "${var.aks_name}-app-apache"
        }
      }
    }
  }
}

resource "kubernetes_deployment" "app-nginx" {
  metadata {
    name      = "${var.aks_name}-app-nginx"
    namespace = kubernetes_namespace.ns.metadata[0].name
    labels = {
      app = "${var.aks_name}-app-nginx"
    }
  }
  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "${var.aks_name}-app-nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.aks_name}-app-nginx"
        }
      }
      spec {
        container {
          image = "nginx:1.27"
          name  = "${var.aks_name}-app-nginx"
        }
      }
    }
  }
}

resource "kubernetes_service" "app_nginx" {
  metadata {
    name      = "${var.aks_name}-app-nginx-svc"
    namespace = kubernetes_namespace.ns.metadata[0].name
  }

  spec {
    selector = {
      app = "${var.aks_name}-app-nginx"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"

  }
}

resource "kubernetes_service" "app_apache" {
  metadata {
    name      = "${var.aks_name}-app-apache-svc"
    namespace = kubernetes_namespace.ns.metadata[0].name
  }

  spec {
    selector = {
      app = "${var.aks_name}-app-apache"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "app_echo" {
  metadata {
    name      = "${var.aks_name}-app-echo-svc"
    namespace = kubernetes_namespace.ns.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.app-echo.metadata[0].name
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
