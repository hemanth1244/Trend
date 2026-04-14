variable "region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "trend-eks-cluster"
}

variable "jenkins_instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
}

variable "public_key_path" {
  description = "Path only if you need to create a key separately"
  default     = ""
}
