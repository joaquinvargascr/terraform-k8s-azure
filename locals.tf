locals {
  loadbalancer_ip   = 0
  load_balancer_url = "http://app.${local.loadbalancer_ip}.nip.io"
}