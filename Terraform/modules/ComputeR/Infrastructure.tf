# EC2 Instances (autoscaling group, AMI), Load Balancing, 
#   DB Instances, SecGroups, KeyPairs, EBS, ...
#   Other

resource "aws_autoscaling_group" "WebServers" {
    name        = "WebServers"
    max_size    = "${var.server_max_count}"
    min_size    = "${var.server_min_count}"
    vpc_zone_identifier = ["${var.vpc_subs}"]
    target_group_arns = ["${aws_lb_target_group.TgWebServerHTTP.arn}","${aws_lb_target_group.TgWebServerHTTPS.arn}"]

    launch_template {
    id      = "${aws_launch_template.centos_ws_template.id}"
    version = "$$Latest"
    }
    
    tags = [
        {
            key                 = "Name"
            value               = "WebServerAutoScaling"
            propagate_at_launch = true
        },
        {
            key                 = "Env"
            value               = "${var.environment}"
            propagate_at_launch = true
        },
        {
            key                 = "Owner"
            value               = "Yordan Ibishev"
            propagate_at_launch = false
        }
    ]
}

resource "aws_launch_template" "centos_ws_template" {
  name                                  = "WebServerTemplate"
  description                           = "Contains base information for the creation of instances (web servers) through the asg."
  disable_api_termination               = true
  ebs_optimized                         = false
  image_id                              = "${var.custom_AMI}"
  instance_initiated_shutdown_behavior  = "terminate"
  key_name                              = "${aws_key_pair.global_ssh_key.key_name}"
  instance_type                         = "${var.web_server_instance_type}" 
  vpc_security_group_ids                = ["${var.webMainSec_id}"]

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      volume_type = "gp2"
      encrypted = true
      delete_on_termination = true
    }
  }
  
  tag_specifications {
    resource_type = "volume"
    tags = {
        Name = "WebServer-Volumes"
        Owner = "Yordan Ibishev"
        Created = "${timestamp()}"        
    }
  }
}


## This is only for demonstration purposes only!
## Implement differently for a production environment. 
resource "aws_key_pair" "global_ssh_key" {
    key_name   = "deployer-key"
    public_key = "${var.public_key}"
}

resource "aws_lb" "appLoadBalancer" {
  name               = "AppLB-WebServer"
  internal           = true
  load_balancer_type = "application"
  subnets            = ["${var.vpc_subs}"]

  enable_deletion_protection = true

  tags = {
    Name = "AppLB-WebServer"
    Owner = "Yordan Ibishev"
  }
}

resource "aws_lb_target_group" "TgWebServerHTTP" {
  name     = "targetAutoscalingWebServersHTTP"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_target_group" "TgWebServerHTTPS" {
  name     = "targetAutoscalingWebServersHTTPS"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.appLoadBalancer.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.TgWebServerHTTP.arn}"
  }
}