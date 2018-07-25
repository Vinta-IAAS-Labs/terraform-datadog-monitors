# Global Terraform
variable "environment" {
  description = "Architecture Environment"
  type        = "string"
}

# Global DataDog
variable "delay" {
  description = "Delay in seconds for the metric evaluation"
  default     = 15
}

variable "message" {
  description = "Message sent when an alert is triggered"
}

variable "filter_tags_use_defaults" {
  description = "Use default filter tags convention"
  default     = "true"
}

variable "filter_tags_custom" {
  description = "Tags used for custom filtering when filter_tags_use_defaults is false"
  default     = "*"
}

variable "custom_webcheck_error_timeframe" {
  description = "Monitor timeframe for custom_webcheck_error monitor [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = "string"
  default     = "last_5m"
}

variable "custom_webcheck_error_silenced" {
  description = "Groups to mute for custom_webcheck_error monitor"
  type        = "map"
  default     = {}
}

variable "custom_webcheck_error_message" {
  description = "Custom message for custom_webcheck_error monitor"
  type        = "string"
  default     = ""
}

variable "custom_webcheck_error_aggregator" {
  description = "Monitor aggregator for custom_webcheck_error monitor [available values: min, max, sum or avg]"
  type        = "string"
  default     = "min"
}

variable "custom_webcheck_latency_timeframe" {
  description = "Monitor timeframe for custom_webcheck_latency [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`]"
  type        = "string"
  default     = "last_5m"
}

variable "custom_webcheck_latency_silenced" {
  description = "Groups to mute for custom_webcheck_latency monitor"
  type        = "map"
  default     = {}
}

variable "custom_webcheck_latency_message" {
  description = "Custom message for custom_webcheck_latency monitor"
  type        = "string"
  default     = ""
}

variable "custom_webcheck_latency_aggregator" {
  description = "Monitor aggregator for custom_webcheck_latency monitor [available values: min, max, sum or avg]"
  type        = "string"
  default     = "min"
}

variable "custom_webcheck_latency_warning" {
  description = "Warn latency in s"
  default     = 0.5
}

variable "custom_webcheck_latency_critical" {
  description = "Critical latency in s"
  default     = 1
}

