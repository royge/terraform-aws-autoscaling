resource "aws_autoscaling_policy" "apiscalingoutpolicy" {
  name = "api-scaling-out-policy"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.apigroup.name}"
}

resource "aws_cloudwatch_metric_alarm" "apicpualarm-out" {
  alarm_name = "api-cpu-alarm-out"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "60"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.apigroup.name}"
  }

  alarm_description = "This metric monitor EC2 instance cpu utilization"
  alarm_actions = ["${aws_autoscaling_policy.apiscalingoutpolicy.arn}"]
}

resource "aws_autoscaling_policy" "apiscalinginpolicy" {
  name = "api-scaling-in-policy"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.apigroup.name}"
}

resource "aws_cloudwatch_metric_alarm" "apicpualarm-in" {
  alarm_name = "api-cpu-alarm-in"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "10"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.apigroup.name}"
  }

  alarm_description = "This metric monitor EC2 instance cpu utilization"
  alarm_actions = ["${aws_autoscaling_policy.apiscalinginpolicy.arn}"]
}
