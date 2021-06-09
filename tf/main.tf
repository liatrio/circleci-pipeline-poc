data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# In case of not creating the cluster, this will be an incompletely configured, unused provider, which poses no problem.
provider "kubernetes" {
  host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, [""]), 0)
  cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, [""]), 0))
  token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, [""]), 0)
}

provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "circleci-pipeline-poc.liatr.io"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "circleci-pipeline-poc"
  }
}

