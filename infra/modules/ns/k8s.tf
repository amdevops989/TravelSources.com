terraform {
  required_providers {
  
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
   
  }
  backend "s3" {
    
  }
}

variable "namespace_name" {
  type        = string
  description = "Name of the Kubernetes namespace to create"
}

variable "k8s_host" {
  type = string
}

variable "k8s_ca" {
  type = string
}

variable "k8s_token" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}


provider "kubernetes" {
  host                   = var.k8s_host
  cluster_ca_certificate = base64decode(var.k8s_ca)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name, "--region", var.region]
  }
}


resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace_name
  }
}


output "namespace_name" {
  value = kubernetes_namespace.this.metadata[0].name
}
