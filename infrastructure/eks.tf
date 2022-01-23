module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = var.eks_cluster_name
  cluster_version = var.k8s_version
  subnets         = module.vpc.private_subnets

  vpc_id      = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = var.root_volume_type
  }
  # for_each = { for idx, worker_groups in var.worker_groups : idx => worker_groups }
  # worker_groups =  [
  #  {    
  #     name                          = each.value.name
  #     instance_type                 = var.worker_groups_instance_type
  #     additional_userdata           = var.worker_groups_additional_userdata
  #     additional_security_group_ids = [each.value.additional_security_group_ids]
  #     asg_desired_capacity          = each.value.asg_desired_capacity
  #   }
  # ]
    worker_groups = [
    {
      name                          = var.worker-name-1
      instance_type                 = var.worker_groups_instance_type
      additional_userdata           = var.worker_groups_additional_userdata
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity          = var.worker-asg_desired_capacity-1
    },
    {
      name                          = var.worker-name-2
      instance_type                 = var.worker_groups_instance_type
      additional_userdata           = var.worker_groups_additional_userdata
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = var.worker-asg_desired_capacity-2
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}