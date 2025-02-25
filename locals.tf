data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "${helm_release.nginx-ingress.name}-ingress-nginx-controller"
    namespace = "ingress"
  }
}

locals {
  loadbalancer_ip   = data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress[0].ip
  load_balancer_url = "app.${local.loadbalancer_ip}.nip.io"
}
