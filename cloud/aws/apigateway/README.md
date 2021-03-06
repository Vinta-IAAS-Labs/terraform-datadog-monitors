# CLOUD AWS APIGATEWAY DataDog monitors

## How to use this module

```
module "datadog-monitors-cloud-aws-apigateway" {
  source = "git::ssh://git@git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors.git//cloud/aws/apigateway?ref={revision}"

  environment = var.environment
  message     = module.datadog-message-alerting.alerting-message
}

```

## Purpose

Creates DataDog monitors with the following checks:

- API Gateway HTTP 4xx errors
- API Gateway HTTP 5xx errors
- API Gateway latency

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| artificial\_requests\_count | Number of false requests used to mitigate false positive in case of low trafic | string | `"5"` | no |
| environment | Environment | string | n/a | yes |
| evaluation\_delay | Delay in seconds for the metric evaluation | string | `"900"` | no |
| filter\_tags | Tags used for filtering | string | `"*"` | no |
| http\_4xx\_requests\_enabled | Flag to enable API Gateway HTTP 4xx requests monitor | string | `"true"` | no |
| http\_4xx\_requests\_extra\_tags | Extra tags for API Gateway HTTP 4xx requests monitor | list(string) | `[]` | no |
| http\_4xx\_requests\_message | Custom message for API Gateway HTTP 4xx requests monitor | string | `""` | no |
| http\_4xx\_requests\_threshold\_critical | Maximum critical acceptable percent of 4xx errors | string | `"30"` | no |
| http\_4xx\_requests\_threshold\_warning | Maximum warning acceptable percent of 4xx errors | string | `"15"` | no |
| http\_4xx\_requests\_time\_aggregator | Monitor aggregator for API HTTP 4xx requests [available values: min, max or avg] | string | `"min"` | no |
| http\_4xx\_requests\_timeframe | Monitor timeframe for API HTTP 4xx requests [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`] | string | `"last_5m"` | no |
| http\_5xx\_requests\_enabled | Flag to enable API Gateway HTTP 5xx requests monitor | string | `"true"` | no |
| http\_5xx\_requests\_extra\_tags | Extra tags for API Gateway HTTP 5xx requests monitor | list(string) | `[]` | no |
| http\_5xx\_requests\_message | Custom message for API Gateway HTTP 5xx requests monitor | string | `""` | no |
| http\_5xx\_requests\_threshold\_critical | Maximum critical acceptable percent of 5xx errors | string | `"20"` | no |
| http\_5xx\_requests\_threshold\_warning | Maximum warning acceptable percent of 5xx errors | string | `"10"` | no |
| http\_5xx\_requests\_time\_aggregator | Monitor aggregator for API HTTP 5xx requests [available values: min, max or avg] | string | `"min"` | no |
| http\_5xx\_requests\_timeframe | Monitor timeframe for API HTTP 5xx requests [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`] | string | `"last_5m"` | no |
| latency\_enabled | Flag to enable API Gateway latency monitor | string | `"true"` | no |
| latency\_extra\_tags | Extra tags for API Gateway latency monitor | list(string) | `[]` | no |
| latency\_message | Custom message for API Gateway latency monitor | string | `""` | no |
| latency\_threshold\_critical | Alerting threshold in milliseconds | string | `"3000"` | no |
| latency\_threshold\_warning | Warning threshold in milliseconds | string | `"1000"` | no |
| latency\_time\_aggregator | Monitor aggregator for API Gateway latency [available values: min, max or avg] | string | `"min"` | no |
| latency\_timeframe | Monitor timeframe for API latency [available values: `last_#m` (1, 5, 10, 15, or 30), `last_#h` (1, 2, or 4), or `last_1d`] | string | `"last_5m"` | no |
| message | Message sent when a monitor is triggered | string | n/a | yes |
| new\_host\_delay | Delay in seconds before monitor new resource | string | `"300"` | no |
| prefix\_slug | Prefix string to prepend between brackets on every monitors names | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| API\_Gateway\_latency\_id | id for monitor API_Gateway_latency |
| API\_http\_4xx\_errors\_count\_id | id for monitor API_http_4xx_errors_count |
| API\_http\_5xx\_errors\_count\_id | id for monitor API_http_5xx_errors_count |

## Related documentation

DataDog documentation: [https://docs.datadoghq.com/integrations/amazon_api_gateway/](https://docs.datadoghq.com/integrations/amazon_api_gateway/)

AWS API Gateway metrics documentation: [https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/api-gateway-metrics-dimensions.html](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/api-gateway-metrics-dimensions.html)
