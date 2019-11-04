module "filter-tags" {
  #source = "../../../common/filter-tags"
  source = "/home/cvauvarin/work/src/git.fr.clara.net/claranet/pt-monitoring/projects/datadog/terraform/monitors/common/filter-tags"

  environment                 = var.environment
  resource                    = "aws_beanstalk"
  filter_tags_use_defaults    = var.filter_tags_use_defaults
  filter_tags_custom          = var.filter_tags_custom
  filter_tags_custom_excluded = var.filter_tags_custom_excluded
}

