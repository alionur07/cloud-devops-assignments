variable "region" {
  type        = string
  default     = "eu-central-1"
}

variable "access_key" {
  description = "access_key of aws account"
  default = __ACCESS_KEY__
}
variable "secret_key" {
  description = "secret of aws account"
  default = __SECRET_KEY__
}

variable "name" {
  default = "contoso-demo-vpc"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "cluster_name" {
  description = "k8s cluster name"
  default     = "contoso-app-cluster"
}

variable "db_password" {
  description = "RDS root user password"
  #sensitive   = true
  default = "contoso-app"
}

variable "db_user" {
  description = "RDS root user"
  default = "postgres"
}

variable "k8s_version" {
  description = "k8s cluster version"
  default     = "1.20"
}

variable "eks_cluster_name" {
  description = "k8s cluster name"
  default     = "contoso-app-cluster"
}

variable "root_volume_type" {
  default     = "gp2"
}

variable "worker_groups_instance_type" {
  default     = "t2.medium"
}

variable "worker_groups_additional_userdata" {
  default     = "echo foo bar"
}

variable "worker-name-1" {
  default     = "contoso-demo-worker-group-1"
}

variable "worker-name-2" {
  default     = "contoso-demo-worker-group-2"
}
variable "worker-asg_desired_capacity-1" {
  default     = "1"
}
variable "worker-asg_desired_capacity-2" {
  default     = "2"
}