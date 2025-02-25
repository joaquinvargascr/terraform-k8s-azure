resource "azurerm_kubernetes_cluster" "aks" {
  location            = var.location
  name                = var.aks_name
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.aks_name}-dns"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_workspace.id
  }

  microsoft_defender {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_workspace.id
  }

}