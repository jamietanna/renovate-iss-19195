terraform {
  required_providers {
    aws = {
      // works, as it's the default registry
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 3.43"
    }
    hcp = {
      source  = "non-existent-registry.example.com/hashicorp/hcp"
      version = ">= 0.18.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.3"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "0.7.2"
    }
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.14"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2"
    }
  }
}

provider "aws" {
  region = var.vpc_region
}

provider "hcp" {
}
