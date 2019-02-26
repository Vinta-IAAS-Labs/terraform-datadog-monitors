resource "datadog_monitor" "nginx_ingress_too_many_5xx" {
  count   = "${var.ingress_5xx_enabled ? 1 : 0}"
  name    = "[${var.environment}] Nginx Ingress VTS 5xx errors {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  message = "${coalesce(var.ingress_5xx_message, var.message)}"

  query = <<EOF
    ${var.ingress_5xx_time_aggregator}(${var.ingress_5xx_timeframe}): default(
      sum:nginx_ingress.nginx_upstream_responses_total${module.filter-tags-5xx.query_alert} by {upstream,ingress_class}.as_rate() /
      (sum:nginx_ingress.nginx_upstream_requests_total${module.filter-tags.query_alert} by {upstream,ingress_class}.as_rate() + ${var.artificial_requests_count})
      * 100, 0) > ${var.ingress_5xx_threshold_critical}
  EOF

  type = "metric alert"

  thresholds {
    warning  = "${var.ingress_5xx_threshold_warning}"
    critical = "${var.ingress_5xx_threshold_critical}"
  }

  notify_no_data      = false
  evaluation_delay    = "${var.evaluation_delay}"
  new_host_delay      = "${var.new_host_delay}"
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = 0
  include_tags        = true
  locked              = false
  require_full_window = true

  silenced = "${var.ingress_5xx_silenced}"

  tags = ["env:${var.environment}", "type:caas", "provider:prometheus", "resource:nginx-ingress-controller-vts", "team:claranet", "created-by:terraform", "${var.ingress_5xx_extra_tags}"]
}

resource "datadog_monitor" "nginx_ingress_too_many_4xx" {
  count   = "${var.ingress_4xx_enabled ? 1 : 0}"
  name    = "[${var.environment}] Nginx Ingress VTS 4xx errors {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  message = "${coalesce(var.ingress_4xx_message, var.message)}"

  query = <<EOF
    ${var.ingress_4xx_time_aggregator}(${var.ingress_4xx_timeframe}): default(
    sum:nginx_ingress.nginx_upstream_responses_total${module.filter-tags-4xx.query_alert} by {upstream,ingress_class}.as_rate() /
    (sum:nginx_ingress.nginx_upstream_requests_total${module.filter-tags.query_alert} by {upstream,ingress_class}.as_rate() + ${var.artificial_requests_count})
    * 100, 0) > ${var.ingress_4xx_threshold_critical}
  EOF

  type = "metric alert"

  thresholds {
    warning  = "${var.ingress_4xx_threshold_warning}"
    critical = "${var.ingress_4xx_threshold_critical}"
  }

  notify_no_data      = false
  evaluation_delay    = "${var.evaluation_delay}"
  new_host_delay      = "${var.new_host_delay}"
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = 0
  include_tags        = true
  locked              = false
  require_full_window = true

  silenced = "${var.ingress_4xx_silenced}"

  tags = ["env:${var.environment}", "type:caas", "provider:prometheus", "resource:nginx-ingress-controller-vts", "team:claranet", "created-by:terraform", "${var.ingress_4xx_extra_tags}"]
}
