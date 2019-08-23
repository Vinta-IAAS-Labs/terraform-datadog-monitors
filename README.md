# DataDog Monitors [![pipeline status](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/badges/master/pipeline.svg)](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/commits/master) #

This repository is used to store all our monitors templates ready to use for generic purpose.

## How to contribute ? ##

First, you may refresh your knowledge and look at the [terminology](https://confluence.fr.clara.net/display/DAT/Getting+started).

To contribute you will need to [report an issue](https://confluence.fr.clara.net/display/DAT/Project+and+Workflow) and create a branch with its Jira ID.

If you would like to resolve an issue or implement new monitors you must follow our [best practices](https://confluence.fr.clara.net/display/DAT/Templates+monitors).

After any change, you will need to run the [auto update scripts](./scripts/README.md) to make sure all is up to date otherwise the CI pipeline will fail.

## Important notes ##

* This repository represents a terraform feature and each first level directory could be imported as a terraform module, you must choose the one(s) you need.
* Each of these modules contains the most commons monitors, but they probably do not fulfill all your customer needs
* You still can create some specific DataDog monitors after importing a module, it's even advisable to complete your needs
* You will find a complete `README.md` on each module, explaining how to use it.
* The `alerting-message` module could be used to easily generate a templating message to use by default but it could be used also multiple times to generate messages for specific monitors.

## Getting started ##

### Terraform ###

Here is the minimum version required to use these modules of integrations.

```
terraform {
  required_version = ">= 0.12.6"
}

```

### DataDog provider ###

Here is the last tester terraform provider version for datadog but next versions should work too.

```
provider "datadog" {
  version = "2.1.0" # last tested working version

  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

```

Both of the `datadog_api_key` and `datadog_app_key` are unique to the each datadog account. You can define them in `terraform.tfvars` file:

```
datadog_api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
datadog_app_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

### Variables ###

Some variables need to be declared.

```
variable "environment" {
  type    = string
  default = "dev"
}

variable "datadog_api_key" {
  type = string
}

variable "datadog_app_key" {
  type = string
}

```

## Modules declaration example ##

A quick example of alerting message module declaration:

```
locals {
  oncall_24x7         = "@pagerduty-MyPagerService_NBH"
  oncall_office_hours = "@pagerduty-MyPagerService_BH"
}

module "datadog-message-alerting" {
  source = "git::ssh://git@git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors.git//common/alerting-message?ref={RELEASE}"

  message_alert   = local.oncall_24x7
  message_warning = local.oncall_office_hours
  message_nodata  = local.oncall_24x7
}

module "datadog-message-alerting-bh-only" {
  source = "git::ssh://git@git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors.git//common/alerting-message?ref={RELEASE}"

  message_alert   = local.oncall_office_hours
  message_warning = local.oncall_office_hours
  message_nodata  = local.oncall_office_hours
}

module "datadog-monitors-system-generic" {
  source = "git::ssh://git@git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors.git//system/generic?ref={RELEASE}"

  environment = var.environment
  message     = module.datadog-message-alerting.alerting-message

  memory_message = module.datadog-message-alerting-bh-only.alerting-message
  # Use variables to customize monitors configuration
}

# Other monitors modules to declare ...
#module "datadog-monitors-my-monitors-set" {
#  source = "git::ssh://git@git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors.git//my/monitors/set?ref={RELEASE}"
#
#  environment = var.environment
#  message     = module.datadog-message-alerting.alerting-message
#}

```

Replace `{revision}` to the last git tag available on this repository.
The `//` is very important, it's a terraform specific syntax used to separate git url and folder path.
`my/monitors/set` represents the path to a monitors set sub directory listed below.

### Monitors summary ###

- [billing](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/billing/)
	- [datadog](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/billing/datadog/)
- [caas](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/)
	- [kubernetes](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/kubernetes/)
		- [ark](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/kubernetes/ark/)
		- [cluster](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/kubernetes/cluster/)
		- [ingress](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/kubernetes/ingress/)
			- [vts](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/kubernetes/ingress/vts/)
		- [node](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/kubernetes/node/)
		- [pod](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/kubernetes/pod/)
		- [workload](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/caas/kubernetes/workload/)
- [cloud](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/)
	- [aws](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/)
		- [alb](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/alb/)
		- [apigateway](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/apigateway/)
		- [elasticache](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/elasticache/)
			- [common](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/elasticache/common/)
			- [memcached](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/elasticache/memcached/)
			- [redis](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/elasticache/redis/)
		- [elasticsearch](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/elasticsearch/)
		- [elb](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/elb/)
		- [kinesis-firehose](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/kinesis-firehose/)
		- [rds](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/rds/)
			- [aurora](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/rds/aurora/)
				- [mysql](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/rds/aurora/mysql/)
				- [postgresql](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/rds/aurora/postgresql/)
			- [common](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/rds/common/)
		- [vpn](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/aws/vpn/)
	- [azure](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/)
		- [apimanagement](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/apimanagement/)
		- [app-services](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/app-services/)
		- [azure-search](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/azure-search/)
		- [cosmosdb](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/cosmosdb/)
		- [datalakestore](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/datalakestore/)
		- [eventgrid](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/eventgrid/)
		- [eventhub](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/eventhub/)
		- [functions](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/functions/)
		- [iothubs](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/iothubs/)
		- [keyvault](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/keyvault/)
		- [load-balancer](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/load-balancer/)
		- [mysql](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/mysql/)
		- [postgresql](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/postgresql/)
		- [redis](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/redis/)
		- [serverfarms](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/serverfarms/)
		- [servicebus](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/servicebus/)
		- [sql-database](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/sql-database/)
		- [sql-elasticpool](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/sql-elasticpool/)
		- [storage](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/storage/)
		- [stream-analytics](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/stream-analytics/)
		- [virtual-machine](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/azure/virtual-machine/)
	- [gcp](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/)
		- [big-query](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/big-query/)
		- [cloud-sql](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/cloud-sql/)
			- [common](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/cloud-sql/common/)
			- [mysql](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/cloud-sql/mysql/)
		- [gce](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/gce/)
			- [instance](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/gce/instance/)
		- [lb](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/lb/)
		- [pubsub](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/cloud/gcp/pubsub/)
- [common](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/common/)
	- [alerting-message](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/common/alerting-message/)
	- [filter-tags](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/common/filter-tags/)
- [database](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/database/)
	- [elasticsearch](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/database/elasticsearch/)
	- [mongodb](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/database/mongodb/)
	- [mysql](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/database/mysql/)
	- [postgresql](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/database/postgresql/)
	- [redis](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/database/redis/)
- [middleware](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/middleware/)
	- [apache](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/middleware/apache/)
	- [nginx](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/middleware/nginx/)
	- [php-fpm](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/middleware/php-fpm/)
- [system](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/system/)
	- [generic](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/system/generic/)
	- [unreachable](https://git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/tree/master/system/unreachable/)
