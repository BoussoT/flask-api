# Groupe de sous-réseaux RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "flask-rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "Flask RDS Subnet Group"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier           = "flask-db"
  allocated_storage    = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = "flaskdb"
  username           = "flaskuser"
  password           = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible = false  # Pas d'accès Internet
  skip_final_snapshot = true
  multi_az            = true   # Recommandé pour la haute disponibilité

  tags = {
    Name = "flask-rds"
  }
}