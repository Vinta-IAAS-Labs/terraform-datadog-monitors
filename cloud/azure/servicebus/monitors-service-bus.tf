resource "datadog_monitor" "servicebus_status" {
  count = "${var.status_enabled ? 1 : 0}"

  name    = "[${var.environment}] Service Bus is down"
  message = "${coalesce(var.status_message, var.message)}"

  query = <<EOF
      ${var.status_time_aggregator}(${var.status_timeframe}): (
        avg:azure.servicebus_namespaces.status${module.filter-tags.query_alert} by {resource_group,region,name}
      ) != 1
EOF

  type = "metric alert"

  silenced = "${var.status_silenced}"

  notify_no_data      = true
  evaluation_delay    = "${var.evaluation_delay}"
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = 0
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.new_host_delay}"

  tags = ["env:${var.environment}", "type:cloud", "provider:azure", "resource:servicebus", "team:claranet", "created-by:terraform", "${var.status_extra_tags}"]
}

resource "datadog_monitor" "service_bus_no_active_connections" {
  count = "${var.no_active_connections_enabled ? 1 : 0}"

  name    = "[${var.environment}] Service Bus has no active connection"
  message = "${coalesce(var.no_active_connections_message, var.message)}"

  query = <<EOF
    ${var.no_active_connections_time_aggregator}(${var.no_active_connections_timeframe}): (
      avg:azure.servicebus_namespaces.active_connections_preview${module.filter-tags.query_alert} by {resource_group,region,name}
      ) < 1
  EOF

  type = "metric alert"

  silenced = "${var.no_active_connections_silenced}"

  notify_no_data      = false
  evaluation_delay    = "${var.evaluation_delay}"
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = 0
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.new_host_delay}"

  tags = ["env:${var.environment}", "type:cloud", "provider:azure", "resource:servicebus", "team:claranet", "created-by:terraform", "${var.no_active_connections_extra_tags}"]
}

resource "datadog_monitor" "service_bus_user_errors" {
  count = "${var.user_errors_enabled ? 1 : 0}"

  name    = "[${var.environment}] Service Bus user errors rate is high {{#is_alert}}{{comparator}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{comparator}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  message = "${coalesce(var.user_errors_message, var.message)}"

  query = <<EOF
      ${var.user_errors_time_aggregator}(${var.user_errors_timeframe}): (
        default(avg:azure.servicebus_namespaces.user_errors.preview${module.filter-tags.query_alert} by {resource_group,region,name}.as_rate(), 0) /
        default(avg:azure.servicebus_namespaces.incoming_requests_preview${module.filter-tags.query_alert} by {resource_group,region,name}.as_rate(), 1)
      ) * 100 > ${var.user_errors_threshold_critical}
  EOF

  type = "metric alert"

  thresholds {
    critical = "${var.user_errors_threshold_critical}"
    warning  = "${var.user_errors_threshold_warning}"
  }

  silenced = "${var.user_errors_silenced}"

  notify_no_data      = false
  evaluation_delay    = "${var.evaluation_delay}"
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = 0
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.new_host_delay}"

  tags = ["env:${var.environment}", "type:cloud", "provider:azure", "resource:servicebus", "team:claranet", "created-by:terraform", "${var.user_errors_extra_tags}"]
}

resource "datadog_monitor" "service_bus_server_errors" {
  count = "${var.server_errors_enabled ? 1 : 0}"

  name    = "[${var.environment}] Service Bus server errors rate is high {{#is_alert}}{{comparator}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{comparator}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  message = "${coalesce(var.server_errors_message, var.message)}"

  query = <<EOF
      ${var.server_errors_time_aggregator}(${var.server_errors_timeframe}): (
        default(avg:azure.servicebus_namespaces.server_errors.preview${module.filter-tags.query_alert} by {resource_group,region,name}.as_rate(), 0) /
        default(avg:azure.servicebus_namespaces.incoming_requests_preview${module.filter-tags.query_alert} by {resource_group,region,name}.as_rate(), 1)
      ) * 100 > ${var.server_errors_threshold_critical}
  EOF

  type = "metric alert"

  thresholds {
    critical = "${var.server_errors_threshold_critical}"
    warning  = "${var.server_errors_threshold_warning}"
  }

  silenced = "${var.server_errors_silenced}"

  notify_no_data      = false
  evaluation_delay    = "${var.evaluation_delay}"
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = 0
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.new_host_delay}"

  tags = ["env:${var.environment}", "type:cloud", "provider:azure", "resource:servicebus", "team:claranet", "created-by:terraform", "${var.server_errors_extra_tags}"]
}

resource "datadog_monitor" "service_bus_queue_growing" {
  count = "${var.queue_growing_enabled ? length(keys(var.queue_growing_config)) : 0}"

  name    = "[${var.environment}] Service Bus queue is growing for ${replace(element(keys(var.queue_growing_config), count.index), "_", " ")} {{#is_alert}}{{comparator}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{comparator}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  message = "${coalesce(var.queue_growing_message, var.message)}"

  query = <<EOF
      ${var.queue_growing_time_aggregator}(${element(keys(var.queue_growing_config), count.index)}): default(
        diff(sum:azure.servicebus_namespaces.count_of_messages_in_a_queue_topic.preview${module.filter-tags.query_alert} by {resource_group,region,name,entityname})
         /
        avg:azure.servicebus_namespaces.count_of_messages_in_a_queue_topic.preview${module.filter-tags.query_alert} by {resource_group,region,name,entityname}
        * 100, 0) > ${element(split(",", element(values(var.queue_growing_config), count.index)), 0)}
  EOF

  type = "metric alert"

  thresholds {
    critical = "${element(split(",", element(values(var.queue_growing_config), count.index)), 0)}"
    warning  = "${element(split(",", element(values(var.queue_growing_config), count.index)), 1)}"
  }

  silenced = "${var.queue_growing_silenced}"

  notify_no_data      = false
  evaluation_delay    = "${var.evaluation_delay}"
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = 0
  include_tags        = true
  locked              = false
  require_full_window = true
  new_host_delay      = "${var.new_host_delay}"

  tags = ["env:${var.environment}", "type:cloud", "provider:azure", "resource:servicebus", "team:claranet", "created-by:terraform", "${var.queue_growing_extra_tags}"]
}
