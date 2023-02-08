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

data "azuread_user" "global_admin" {
  user_principal_name = var.global_admin_user_principal
}

data "azuread_service_principal" "ci" {
  display_name = var.ci_service_principal_name
}

resource "azuread_group" "cluster_admins" {
  display_name     = "${var.name}-cluster-admins"
  owners           = [data.azuread_user.global_admin.object_id]
  security_enabled = true

  members = [
    data.azuread_user.global_admin.object_id,
    data.azuread_service_principal.ci.object_id
  ]
}

resource "azurerm_role_assignment" "cluster_admins_group" {
  scope                = azurerm_kubernetes_cluster.main.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = azuread_group.cluster_admins.object_id
}