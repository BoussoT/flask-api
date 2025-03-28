variable "aws_region" {
  description = "Région AWS"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI pour Ubuntu 20.04"
  default     = ""
}

variable "ec2_instance_type" {
  description = "Type d'instance EC2"
  default     = "t3.medium"
}

variable "key_name" {
  description = "Nom de la clé SSH pour se connecter à l'EC2"
  type        = string
}

variable "eks_cluster_name" {
  description = "Nom du cluster EKS"
  default     = "eks-cluster"
}

variable "db_name" {
  description = "Nom de la base de données"
  default     = "flaskdb"
}

variable "db_username" {
  description = "Nom d'utilisateur RDS"
  default     = "admin"
}

variable "db_password" {
  description = "Mot de passe RDS"
  type        = string
  sensitive   = true
}
