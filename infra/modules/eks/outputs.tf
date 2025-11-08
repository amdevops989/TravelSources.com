output "cluster_id" {
  description = "EKS Cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_arn" {
  description = "EKS Cluster ARN"
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Cluster SG ID"
  value       = module.eks.cluster_security_group_id
}

output "node_group_arn" {
  description = "Demo node group ARN"
  value       = module.eks.node_groups["demo_nodes"].arn
}

output "node_group_name" {
  description = "Demo node group name"
  value       = module.eks.node_groups["demo_nodes"].id
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA"
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  description = "OIDC provider URL for IRSA"
  value       = module.eks.oidc_provider_url
}

output "storageclass_name" {
  description = "Name of KMS-encrypted PVC StorageClass"
  value       = kubernetes_storage_class.gp3_encrypted.metadata[0].name
}
