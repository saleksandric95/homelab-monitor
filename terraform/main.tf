provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "grafana_proxy" {
  name        = "grafana-proxy-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 9090
  to_port     = 9090
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
  from_port   = 3000
  to_port     = 3000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "grafana_proxy" {
  ami                    = "ami-0fc0d6e8d70ab2d42"
  instance_type          = "t3.micro"
  key_name               = "uptime-monitor-key"
  vpc_security_group_ids = [aws_security_group.grafana_proxy.id]

  tags = {
    Name = "grafana-proxy"
  }
}

output "public_ip" {
  value = aws_instance.grafana_proxy.public_ip
}