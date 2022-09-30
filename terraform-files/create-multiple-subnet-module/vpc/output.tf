output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.myvpc.id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.mygw.id
}

output "myroutetable_public" {
  description = "List of IDs of public subnet"
  value       = aws_route_table.myroutetable_public.id
}

output "mysubnet_public" {
  description = "List of IDs of public route tables"
  value       = aws_subnet.mysubnet_public[*].id
}

output "myroutetableassociation_public" {
  value = aws_route_table_association.myroutetableassociation_public[*].id
}

#output "mysubnet_public" {
#  description = "List of IDs of public route tables"
#  value       = aws_subnet.mysubnet_public.id
#}

#output "myroutetableassociation_public" {
#  value = aws_route_table_association.myroutetableassociation_public.id
#}

output "mysg_mgmt" {
  value = aws_security_group.mysg_mgmt.id
}

