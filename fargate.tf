# Création du Profile Fargate pour exécuter des pods serverless
resource "aws_eks_fargate_profile" "flask_api" {
  cluster_name           = aws_eks_cluster.eks.name 
  fargate_profile_name   = "flask-api-fargate"
  pod_execution_role_arn = aws_iam_role.fargate_execution_role.arn
  subnet_ids             = [
    aws_subnet.private_subnet_1.id, 
    aws_subnet.private_subnet_2.id
  ]

  selector {
    namespace = "flask-api"  # Namespace des pods qui seront exécutés sur Fargate
  }

  tags = {
    Name = "flask-api-fargate"
  }
}

# Rôle IAM pour exécuter les pods sur Fargate
resource "aws_iam_role" "fargate_execution_role" {
  name = "eks-fargate-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

#  Attacher les permissions nécessaires au rôle Fargate
resource "aws_iam_role_policy_attachment" "fargate_execution_policy" {
  role       = aws_iam_role.fargate_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}
