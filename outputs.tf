output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}
output "alb_dns" {
  value = aws_lb.app_alb.dns_name 
}
output "ec2_public_ip" {
  value = aws_instance.elastic_ec2.public_ip
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet_1.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet_1.id
}