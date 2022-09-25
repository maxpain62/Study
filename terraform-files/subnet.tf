resource "aws_subnet" "mysubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/20"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = "true"
    enable_resource_name_dns_a_record_on_launch = "true"

    tags = {
      Name = "mysubnet"
    }
}

