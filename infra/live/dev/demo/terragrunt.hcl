include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "eks" {
  config_path = "../eks"

  # Mock outputs for dev testing
  mock_outputs = {
    cluster_name           = "mock-cluster"
    cluster_endpoint       = "https://mock-cluster-endpoint"
    cluster_ca_certificate = "mock-ca-data"
    cluster_token          = "mock-token"
  }

  mock_outputs_merge_with_state = true
}

terraform {
  source = "../../../modules/ns"
}

inputs = {
  namespace_name = "external-dns"
  k8s_host       = dependency.eks.outputs.cluster_endpoint
  k8s_ca         = dependency.eks.outputs.cluster_ca_certificate
  k8s_token      = dependency.eks.outputs.cluster_token
  cluster_name   = dependency.eks.outputs.cluster_name
  region         = "us-east-1"
  
}
