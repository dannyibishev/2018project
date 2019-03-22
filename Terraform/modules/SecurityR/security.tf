# For simplicity, all ip addresses are permitted, 
# Please do not use 0.0.0.0/0 in production use cases!!!

resource "aws_security_group" "webMainSec" {
  name        = "WebMainSecurityGroup"
  description = "Allows SSH, ICMP, HTTPS, MYSQL Related Traffic to the instances attached with this sec group."
  vpc_id      = "${var.vpc_id}"

    ingress {
    # SSH ACCESS
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    # HTTPS ACCESS
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    # MYSQL ACCESS From any Source Port (Restrict this when using in production!)
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    # ICMP - ECHO (ICMP TYPE 8)
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "icmp"
    from_port = 8
    to_port = 0
  }
    ingress {
    # ICMP - Echo Reply (ICMP TYPE 0)
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "icmp"
    from_port = 0
    to_port = 0
  }
   ingress {
    # ICMP - Destination Unavailable (ICMP TYPE 3)
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "icmp"
    from_port = 3
    to_port = -1
  }
   ingress {
    # ICMP - Time Exceeded (ICMP TYPE 11)
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "icmp"
    from_port = 11
    to_port = -1
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Permitted Web Traffic"
    Owner       = "Yordan Ibishev"
    Environment = "${var.environment}"
  }
}