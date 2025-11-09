include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

# -----------------------------
# Dependencies
# -----------------------------
dependency "eks" {
  config_path = "../eks"

  # === Mock outputs for local testing / dev ===
  mock_outputs = {
    cluster_name              = "mock-cluster"
    cluster_endpoint          = "https://mock-cluster-endpoint"
    cluster_ca_certificate    = "mock-ca-data"
    cluster_token             = "mock-token"
    oidc_provider_arn         = "arn:aws:iam::123456789012:oidc-provider/mock"
    oidc_provider_url         = "https://oidc.mock.eks.amazonaws.com/id/ABC123"
  }

  # Merge mock outputs with real state if exists
  mock_outputs_merge_with_state = true
}

dependency "external_dns" {
  config_path = "../external-dns"
}

terraform {
  source = "../../../modules/cert-manager"
}

inputs = {
  cluster_name         = dependency.eks.outputs.cluster_name
  region               = dependency.eks.outputs.region
  k8s_host             = dependency.eks.outputs.cluster_endpoint
  k8s_ca               = dependency.eks.outputs.cluster_ca_certificate
  k8s_token            = dependency.eks.outputs.k8s_token
  k8s_namespace        = "cert-manager"
  service_account_name = "cert-manager-sa"
}
