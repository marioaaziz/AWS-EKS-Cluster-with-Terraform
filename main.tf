#vpc
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
  
}
# Subnet 1
resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/20"
 availability_zone = "us-east-2a"
 map_public_ip_on_launch = true
  
}
#subnet 2
resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.16.0/20"
 availability_zone = "us-east-2b"
 map_public_ip_on_launch = true
  
}
#subnet 3
resource "aws_subnet" "sub3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.32.0/20"
 availability_zone = "us-east-2c"
 map_public_ip_on_launch = true
  
}
#internet gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.myvpc.id
}
#route table
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.myvpc.id

  route { #public
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
   route { #local
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}
#rout table association
resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.my-route-table.id
}
resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.sub2.id
  route_table_id = aws_route_table.my-route-table.id
}
resource "aws_route_table_association" "rta3" {
  subnet_id = aws_subnet.sub3.id
  route_table_id = aws_route_table.my-route-table.id
}

#EKS
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "my-cluster-eks"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id                   = aws_vpc.myvpc.id
  subnet_ids               = [aws_subnet.sub1.id, aws_subnet.sub2.id, aws_subnet.sub3.id]
  control_plane_subnet_ids = [aws_subnet.sub1.id, aws_subnet.sub2.id, aws_subnet.sub3.id]

  eks_managed_node_groups = {
    green = {
      min_size       = 1
      max_size       = 1
      desired_size   = 1
      instance_types = ["t3.medium"]
    }
  }
}
