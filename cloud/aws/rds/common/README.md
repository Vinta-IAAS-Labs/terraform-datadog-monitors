# CLOUD AWS RDS COMMON DataDog monitors

## How to use this module

```
module "datadog-monitors-cloud-aws-rds-common" {
  source = "git::ssh://git@bitbucket.org/morea/terraform.feature.datadog.git//cloud/aws/rds/common?ref={revision}"

  environment = "${var.environment}"
  message     = "${module.datadog-message-alerting.alerting-message}"
}

```

## Purpose

Creates DataDog monitors with the following checks:

- RDS instance CPU high
- RDS instance free space
- RDS replica lag

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cpu_enabled | Flag to enable RDS CPU usage monitor | string | `true` | no |
| cpu_extra_tags | Extra tags for RDS CPU usage monitor | list | `[]` | no |
| cpu_message | Custom message for RDS CPU usage monitor | string | `` | no |
| cpu_silenced | Groups to mute for RDS CPU usage monitor | map | `{}` | no |
| cpu_threshold_critical | CPU usage in percent (critical threshold) | string | `90` | no |
| cpu_threshold_warning | CPU usage in percent (warning threshold) | string | `80` | no |
| cpu_time_aggregator | Monitor aggregator for RDS CPU usage [available values: min, max or avg] | string | `min` | no |
| cpu_timeframe | Monitor timeframe for RDS CPU usage [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`] | string | `last_15m` | no |
| diskspace_enabled | Flag to enable RDS free diskspace monitor | string | `true` | no |
| diskspace_extra_tags | Extra tags for RDS free diskspace monitor | list | `[]` | no |
| diskspace_message | Custom message for RDS free diskspace monitor | string | `` | no |
| diskspace_silenced | Groups to mute for RDS free diskspace monitor | map | `{}` | no |
| diskspace_threshold_critical | Disk free space in percent (critical threshold) | string | `10` | no |
| diskspace_threshold_warning | Disk free space in percent (warning threshold) | string | `20` | no |
| diskspace_time_aggregator | Monitor aggregator for RDS free diskspace [available values: min, max or avg] | string | `min` | no |
| diskspace_timeframe | Monitor timeframe for RDS free diskspace [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`] | string | `last_15m` | no |
| environment | Architecture Environment | string | - | yes |
| evaluation_delay | Delay in seconds for the metric evaluation | string | `900` | no |
| filter_tags_custom | Tags used for custom filtering when filter_tags_use_defaults is false | string | `*` | no |
| filter_tags_use_defaults | Use default filter tags convention | string | `true` | no |
| message | Message sent when an alert is triggered | string | - | yes |
| new_host_delay | Delay in seconds before monitor new resource | string | `300` | no |
| replicalag_enabled | Flag to enable RDS replica lag monitor | string | `true` | no |
| replicalag_extra_tags | Extra tags for RDS replica lag monitor | list | `[]` | no |
| replicalag_message | Custom message for RDS replica lag monitor | string | `` | no |
| replicalag_silenced | Groups to mute for RDS replica lag monitor | map | `{}` | no |
| replicalag_threshold_critical | replica lag in seconds (critical threshold) | string | `300` | no |
| replicalag_threshold_warning | replica lag in seconds (warning threshold) | string | `200` | no |
| replicalag_timeframe | Monitor timeframe for RDS replica lag monitor [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`] | string | `last_5m` | no |

## Outputs

| Name | Description |
|------|-------------|
| rds_cpu_90_15min_id | id for monitor rds_cpu_90_15min |
| rds_free_space_low_id | id for monitor rds_free_space_low |
| rds_replica_lag_id | id for monitor rds_replica_lag |

## Related documentation

DataDog documentation: [https://docs.datadoghq.com/integrations/amazon_rds/](https://docs.datadoghq.com/integrations/amazon_rds/)

AWS RDS Instance metrics documentation: [https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/rds-metricscollected.html](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/rds-metricscollected.html)
