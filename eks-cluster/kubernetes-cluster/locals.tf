locals {
  name_prefix           = "${var.project}-${var.environment}"
  cluster_name          = "${local.name_prefix}-cluster"
  nodegroup1_name       = "${local.name_prefix}-worker-nodegroup-1"
  cluster_role_name     = "${local.name_prefix}-cluster-iam-role"
  cluster_noderole_name = "${local.name_prefix}-workers-iam-role"
}