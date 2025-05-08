# -----------------------------
# EKS cluster
# -----------------------------
resource "aws_eks_cluster" "eks-cluster" {
  name    = local.cluster_name
  version = var.k8s_version

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids             = var.subnets
    endpoint_public_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

# -----------------------------
# node group
# -----------------------------
resource "aws_eks_node_group" "worker-nodes" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = local.nodegroup1_name
  node_role_arn   = aws_iam_role.node_role.arn

  subnet_ids = var.subnets

  instance_types = var.ec2_types

  scaling_config {
    desired_size = var.workers_desired
    max_size     = var.workers_max
    min_size     = var.workers_min
  }

  depends_on = [
    aws_eks_cluster.eks-cluster,
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}