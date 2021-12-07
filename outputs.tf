output "az2-firepower-appliance" {
  value       = length(aws_instance.az2_ftdv)
  description = "Firepower Management Address"
}

output "az1-firepower-appliance" {
  value       = length(aws_instance.az1_ftdv)
  description = "Firepower Management Address"
}