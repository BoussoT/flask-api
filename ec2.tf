# Data source pour récupérer la dernière AMI Ubuntu LTS
data "aws_ami" "ubuntu_latest" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "elastic_ec2" {
  # Utilisation de l'AMI dynamique si non spécifiée
  ami           = coalesce(var.ami_id, data.aws_ami.ubuntu_latest.id)
  instance_type = var.ec2_instance_type 
  key_name      = "ma-cle-ssh"

  # Utilisation du premier sous-réseau privé
  subnet_id              = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Configuration du volume root
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 50  # Taille en Go adaptée à Elastic Stack
    delete_on_termination = true
    encrypted             = true
  }

  # Données utilisateur pour l'installation d'Elastic Stack
  user_data = templatefile("${path.module}/templates/elastic_stack_setup.sh.tpl", {
    elasticsearch_version = "8.5.3"
    kibana_version        = "8.5.3"
    heartbeat_version     = "8.5.3"
  })

  # Activer cloud-init pour le traitement des données utilisateur
  user_data_replace_on_change = true

  # Marquages pour une meilleure traçabilité
  tags = {
    Name        = "elastic-stack"
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
    Component   = "ELK-Stack"
  }

  # Activer la surveillance détaillée
  monitoring = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_ebs_volume" "elastic_data" {
  availability_zone = data.aws_availability_zones.available.names[0]  # Selects the first available AZ
  size              = 20
  type              = "gp2"

  tags = {
    Name        = "elastic-data-volume"
  }
}
resource "aws_volume_attachment" "elastic_data_attachment" {
  device_name = "/dev/sdh"  # Or appropriate device name
  volume_id   = aws_ebs_volume.elastic_data.id
  instance_id = aws_instance.elastic_ec2.id
}