include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path = "../network"  # points to your live VPC environment
  mock_outputs = {
    vpc_id = "vpc-123456"
    public_subnets = ["subnet-a","subnet-b"]
    private_subnets = ["subnet-c","subnet-d"]
  }
  mock_outputs_merge_with_state = true
}

terraform {
  source = "../../../modules/eks"
}

inputs = {
  cluster_name       = "travelsources-eks-demo"
  region             = "us-east-1"
  profile            = "devops-am"
  env                = "dev"
  vpc_id             = dependency.vpc.outputs.vpc_id
  private_subnets    = dependency.vpc.outputs.private_subnets
  node_instance_type = "t3.small"
  node_desired_capacity = 1
  node_min_capacity     = 1
  node_max_capacity     = 2
  ssh_key_name          = ""
  kms_key_id            = "<KMS_KEY_ID>"
  tags = {
    Project     = "TravelSources"
    Environment = "dev"
  }
}
