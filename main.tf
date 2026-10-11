resource "grafana_cloud_provider_azure_credential" "cloud_provider_azure_credentials" {
  for_each = var.cloud_provider_azure_credentials

  client_id                       = each.value.client_id
  client_secret                   = each.value.client_secret
  name                            = each.value.name
  stack_id                        = each.value.stack_id
  tenant_id                       = each.value.tenant_id
  enabled                         = each.value.enabled
  resource_tags_to_add_to_metrics = each.value.resource_tags_to_add_to_metrics
  static_labels                   = each.value.static_labels

  dynamic "auto_discovery_configuration" {
    for_each = each.value.auto_discovery_configuration != null ? each.value.auto_discovery_configuration : []
    content {
      dynamic "resource_type_configurations" {
        for_each = auto_discovery_configuration.value.resource_type_configurations
        content {
          dynamic "metric_configuration" {
            for_each = resource_type_configurations.value.metric_configuration != null ? resource_type_configurations.value.metric_configuration : []
            content {
              aggregations = metric_configuration.value.aggregations
              dimensions   = metric_configuration.value.dimensions
              name         = metric_configuration.value.name
            }
          }
          resource_type_name = resource_type_configurations.value.resource_type_name
        }
      }
      subscription_id = auto_discovery_configuration.value.subscription_id
    }
  }

  dynamic "resource_discovery_tag_filter" {
    for_each = each.value.resource_discovery_tag_filter != null ? each.value.resource_discovery_tag_filter : []
    content {
      key   = resource_discovery_tag_filter.value.key
      value = resource_discovery_tag_filter.value.value
    }
  }
}

