resource "aws_instance" "devserver" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public_http_traffic.id]

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF


  tags = merge(local.common_tags, {
    Name = "kode-devserver"
  })
}


resource "aws_security_group" "public_http_traffic" {
  name        = "public-http-traffic"
  description = "Security Group allowing traffic from http and https"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "public-http-traffic"
  })
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}



resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
