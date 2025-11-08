terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50" # ✅ works with EKS module v20+
    }
  }

  backend "s3" {}
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8" # ✅ Use the latest v20 release line

  cluster_name    = var.cluster_name
  cluster_version = var.k8s_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets

  enable_irsa                  = true
  manage_aws_auth_configmap    = true
  cluster_enabled_log_types    = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  eks_managed_node_groups = {
    demo_nodes = {
      desired_size   = var.node_desired_capacity
      min_size       = var.node_min_capacity
      max_size       = var.node_max_capacity
      instance_types = [var.node_instance_type]
      key_name       = var.ssh_key_name
      capacity_type  = "ON_DEMAND"
      tags           = merge(var.tags, { Name = "${var.cluster_name}-node" })
    }
  }

  tags = merge(var.tags, { Environment = var.env })
}
