output "rds_aurora_mysql_replica_lag_id" {
  description = "id for monitor rds_aurora_mysql_replica_lag"
  value       = datadog_monitor.rds_aurora_mysql_replica_lag.*.id
}

