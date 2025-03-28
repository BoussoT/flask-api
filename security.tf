resource "aws_security_group" "alb_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "Security Group for ALB"
}

resource "aws_security_group" "eks_sg" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main_vpc.id
}
