module "filter-tags" {
  source = "../../../common/filter-tags"

  environment                 = var.environment
  resource                    = "aws_beanstalk"
  filter_tags_use_defaults    = var.filter_tags_use_defaults
  filter_tags_custom          = var.filter_tags_custom
  filter_tags_custom_excluded = var.filter_tags_custom_excluded
}

# As some metrics are send per host and per beanstalk env
# we need to do some exclusion to alert on the right value
module "filter-tags-no-host" {
  source = "../../../common/filter-tags"

  environment                 = var.environment
  resource                    = "aws_beanstalk"
  filter_tags_use_defaults    = var.filter_tags_use_defaults
  filter_tags_custom          = var.filter_tags_custom
  filter_tags_custom_excluded = var.filter_tags_custom_excluded
  extra_tags_excluded         = ["aws_cloudformation_logical-id:awsebautoscalinggroup"]
}

