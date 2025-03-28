resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.public_subnet_1.id, 
    aws_subnet.public_subnet_2.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "app-alb"
  }
}
