resource "azurerm_kubernetes_cluster" "aks" {
  location            = data.azurerm_resource_group.rg.location
  name                = "default"
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.aks_kubernetes_version
  tags                = var.tags

  default_node_pool { # Required
    name                        = "default"
    vnet_subnet_id              = azurerm_subnet.aks.id
    auto_scaling_enabled        = true
    min_count                   = var.aks_node_pool_min_count
    max_count                   = var.aks_node_pool_max_count
    temporary_name_for_rotation = "temppool"
    tags                        = var.tags
  }
  identity {
    type = "SystemAssigned"

    # Computed attributes (read-only):
    # principal_id = (computed)
    # tenant_id    = (computed)
  }
  network_profile {
    network_plugin    = var.aks_network_plugin
    load_balancer_sku = var.aks_load_balancer_sku
  }

  # Computed attributes (read-only):
  # current_kubernetes_version         = (computed)
  # fqdn                               = (computed)
  # http_application_routing_zone_name = (computed)
  # kube_admin_config                  = (computed)
  # kube_admin_config_raw              = (computed)
  # kube_config                        = (computed)
  # kube_config_raw                    = (computed)
  # node_resource_group_id             = (computed)
  # oidc_issuer_url                    = (computed)
  # portal_fqdn                        = (computed)
  # private_fqdn                       = (computed)

  lifecycle {
    ignore_changes = [
      default_node_pool[0].upgrade_settings,
    ]
  }

}
