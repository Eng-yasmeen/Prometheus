provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "monitoring_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type = "t3.micro"
  key_name = "monitoring-key"

  vpc_security_group_ids = [aws_security_group.prom_sg.id]

  tags = {
    Name = "monitoring-ec2"
  }
}

resource "aws_security_group" "prom_sg" {
  name = "prometheus-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
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
