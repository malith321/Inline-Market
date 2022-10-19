resource "azurerm_resource_group" "devops" {
  name     = "devops"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "devops" {
  name                = "devops"
  location            = azurerm_resource_group.devops.location
  resource_group_name = azurerm_resource_group.devops.name
  dns_prefix          = "devops"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.devops.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.edevops.kube_config_raw

  sensitive = true
}
