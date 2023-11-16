#EC2 
resource "aws_instance" "web" {
  ami = var.ami
  instance_type =  var.instance_type
  subnet_id = var.subnet_id
  user_data = file("scripts/web-server-setup-sh")  # How >>> https://developer.hashicorp.com/terraform/language/functions/file
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]   #ResourceType.LN.id >>https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-web-server"
  })

}

#SECURITY GROUP FOR RDS GROUP CREATION
resource "aws_security_group" "web_server_sg" {
  name        = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-web-server-sg"
  description = "Allow web traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "traffic port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "traffic port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-web-server-sg"
  })  

}

