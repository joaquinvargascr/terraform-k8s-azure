resource "kubernetes_ingress_v1" "webapp_ingress" {
  metadata {
    name      = "${var.aks_name}-webapp-ingress"
    namespace = kubernetes_namespace.ns.metadata[0].name
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.app_echo.metadata[0].name
              port {
                number = kubernetes_service.app_echo.spec[0].port[0].port
              }
            }
          }
        }

        path {
          path      = "/apache"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.app_apache.metadata[0].name
              port {
                number = kubernetes_service.app_apache.spec[0].port[0].port
              }
            }
          }
        }

        path {
          path      = "/nginx"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.app_nginx.metadata[0].name
              port {
                number = kubernetes_service.app_nginx.spec[0].port[0].port
              }
            }
          }
        }
      }
    }
  }
}
