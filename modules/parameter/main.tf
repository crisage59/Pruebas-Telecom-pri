resource "aws_ssm_parameter" "this" {
  name  = "/cloudwatch-agent/prod_${var.app}_cw_config"
  type  = "String"
  value = <<EOF
{
	"agent": {
		"metrics_collection_interval": 300,
		"run_as_user": "cwagent"
	},
	"metrics": {
		"append_dimensions": {
			"AutoScalingGroupName": "$${aws:AutoScalingGroupName}",
			"ImageId": "$${aws:ImageId}",
			"InstanceId": "$${aws:InstanceId}",
			"InstanceType": "$${aws:InstanceType}"
		},
    "aggregation_dimensions" : [["AutoScalingGroupName"], ["InstanceId", "InstanceType"]],
		"metrics_collected": {
			"cpu": {
				"measurement": [
					"cpu_usage_user",
					"cpu_usage_system"
				],
				"metrics_collection_interval": 300,
				"resources": [
					"*"
				],
				"totalcpu": false
			},
			"disk": {
				"measurement": [
					"used_percent"
				],
				"metrics_collection_interval": 300,
				"resources": [
					"*"
				],
				"ignore_file_system_types": [
					"sysfs", "devtmpfs", "tmpfs"
				]
			},
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
				"metrics_collection_interval": 300
			}
		}
	},
	"logs": {
		"logs_collected": {
			"files": {
				"collect_list": [
					{
						"file_path": "/var/log/cloud-init-output.log",
						"log_group_name": "/prod/wp-${var.app}/cloud-init-output.log",
						"log_stream_name": "{instance_id}",
						"retention_in_days": 14,
						"timezone": "UTC"
					},
					{
						"file_path": "/var/log/httpd/access_log",
						"log_group_name": "/prod/wp-${var.app}/access.log",
						"log_stream_name": "{instance_id}",
						"retention_in_days": 14,
						"timezone": "UTC"
					},
					{
						"file_path": "/var/log/httpd/error_log",
						"log_group_name": "/prod/wp-${var.app}/error.log",
						"log_stream_name": "{instance_id}",
						"retention_in_days": 14,
						"timezone": "UTC"
					},
					{
						"file_path": "/var/log/php-fpm/*-error.log",
						"log_group_name": "/prod/wp-${var.app}/php-fpm-error.log",
						"log_stream_name": "{instance_id}",
						"retention_in_days": 14,
						"timezone": "UTC"
					}
				]
			}
		}
	}
}
EOF
}

