module "general" {
  source = "../../modules/general"

  name     = var.name
  location = var.location
}

module "containers" {
  source = "../../modules/containers"

  name                        = var.name
  location                    = var.location
  resource_group_name         = module.general.resource_group_name
  global_admin_user_principal = var.global_admin_user_principal
  ci_service_principal_name   = var.ci_service_principal_name
}