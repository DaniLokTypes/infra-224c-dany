# output "subnet_ids" {
#   value = [
#     aws_subnet.subnet_1.id,
#     aws_subnet.subnet_2.id,
#     aws_subnet.subnet_3.id
#   ]
# }

output "subnet_ids" {
  description = "List of all subnet IDs"
  value       = [for subnet in aws_subnet.subnets : subnet.id]
}