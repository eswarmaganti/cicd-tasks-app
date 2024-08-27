resource "aws_eks_cluster" "eks" {
  name     = "eks-cluster"
  role_arn = var.master_arn
  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}


# create eks node group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "eks-worker-node-group"
  node_role_arn   = var.worker_arn
  instance_types  = [var.instance_type]
  disk_size       = 20
  capacity_type   = "ON_DEMAND"
  subnet_ids      = var.private_subnet_ids
  scaling_config {
    max_size     = 4
    min_size     = 2
    desired_size = 2
  }
  update_config {
    max_unavailable = 1
  }
  remote_access {
    ec2_ssh_key               = var.public_key_name
    source_security_group_ids = [var.eks_sg_id]
  }

}
