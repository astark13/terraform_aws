
###################
### policy_type 
# Target tracking scaling — Increase or decrease the current capacity of the group
#                           based on a target value for a specific metric.
# Step scaling — Increase or decrease the current capacity of the group based on a set of scaling adjustments, 
#                known as step adjustments, that vary based on the size of the alarm breach.
# Simple scaling — Increase or decrease the current capacity of the group based on a single scaling adjustment.
###################
### cooldown — a configurable setting that helps ensure to not launch or terminate additional instances
#                   before previous scaling activities take effect. 
###################
### adjustment_type
# ChangeInCapacity — Increment or decrement the current capacity of the group by the specified value.
#                    A positive value increases the capacity and a negative adjustment value decreases the capacity.
#                    For example: If the current capacity of the group is 3 and the adjustment is 5,
#                    then when this policy is performed, we add 5 capacity units to the capacity for a total of 8 capacity units.
# ExactCapacity — Change the current capacity of the group to the specified value. Specify a non-negative value with this adjustment type.
#                 For example: If the current capacity of the group is 3 and the adjustment is 5, then when this policy is performed, we change the capacity to 5 capacity units.
# PercentChangeInCapacity — Increment or decrement the current capacity of the group by the specified percentage. 
#                           A positive value increases the capacity and a negative value decreases the capacity. 
#                           For example: If the current capacity is 10 and the adjustment is 10 percent, then when this policy is performed, we add 1 capacity unit to the capacity for a total of 11 capacity units. 

resource "aws_autoscaling_policy" "bat" {
  count                  = var.asgplc == null ? 0 : 1  
  name                   = var.asgplc.name
  policy_type            = var.asgplc.policy_type        
  adjustment_type        = var.asgplc.adjustment_type    
  autoscaling_group_name = var.asgplc.autoscaling_group_name
  target_tracking_configuration {
    predefined_metric_specification {
      # Valid values are: ASGTotalCPUUtilization, ASGTotalNetworkIn,
      # ASGTotalNetworkOut, ALBTargetGroupRequestCount
      predefined_metric_type = var.asgplc.predefined_metric_type  
    }
  target_value = var.asgplc.target_value                        
  }
}