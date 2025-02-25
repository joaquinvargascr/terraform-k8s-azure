resource "kubernetes_ingress" "example_ingress" {
  metadata {
    name = "example-ingress"
    namespace = kubernetes_namespace.ns.metadata.0.name
  }

  spec {
    backend {
      service_name = kubernetes_service.nginx-svc.metadata.0.name
      service_port = kubernetes_service.nginx-svc.spec.0.port.0.port
    }

    rule {
      http {
        path {
          backend {
            service_name = kubernetes_service.nginx-svc.metadata.0.name
            service_port = kubernetes_service.nginx-svc.spec.0.port.0.port
          }

          path = "/app1/*"
        }
      }
    }
  }
}