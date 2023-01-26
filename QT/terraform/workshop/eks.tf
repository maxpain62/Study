resource "aws_eks_cluster" "my_cluster" {
    name = "my_cluster"
    role_arn = "arn:aws:iam::515138065344:role/cluster-admin-role"
    vpc_config = {
        subnet_ids = ["subnet-0fb6aa3631bea2cfd", "subnet-0aec41c32cf6a3788"]
        }
  
}