variable "cloud_provider_azure_credentials" {
  description = <<EOT
Map of cloud_provider_azure_credentials, attributes below
Required:
    - client_id
    - client_secret
    - name
    - stack_id
    - tenant_id
Optional:
    - enabled
    - resource_tags_to_add_to_metrics
    - static_labels
    - auto_discovery_configuration (block):
        - resource_type_configurations (required, block):
            - metric_configuration (optional, block):
                - aggregations (optional)
                - dimensions (optional)
                - name (optional)
            - resource_type_name (optional)
        - subscription_id (required)
    - resource_discovery_tag_filter (block):
        - key (required)
        - value (required)
EOT

  type = map(object({
    client_id                       = string
    client_secret                   = string
    name                            = string
    stack_id                        = string
    tenant_id                       = string
    enabled                         = optional(bool)
    resource_tags_to_add_to_metrics = optional(set(string))
    static_labels                   = optional(map(string))
    auto_discovery_configuration = optional(list(object({
      resource_type_configurations = list(object({
        metric_configuration = optional(list(object({
          aggregations = optional(list(string))
          dimensions   = optional(list(string))
          name         = optional(string)
        })))
        resource_type_name = optional(string)
      }))
      subscription_id = string
    })))
    resource_discovery_tag_filter = optional(list(object({
      key   = string
      value = string
    })))
  }))
}

