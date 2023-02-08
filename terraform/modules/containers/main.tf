resource "azurerm_kubernetes_cluster" "main" {
  name                   = "${var.name}-aks"
  location               = var.location
  resource_group_name    = var.resource_group_name
  dns_prefix             = var.name
  local_account_disabled = true

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_B2s"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }
}