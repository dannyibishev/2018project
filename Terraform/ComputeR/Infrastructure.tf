# EC2 Instances (autoscaling group, AMI), Load Balancing, 
#   DB Instances, SecGroups, KeyPairs, EBS, ...
#   Other
resource "aws_autoscaling_group" "WebServers" {
    name        = "WebServers"
    max_size    = 3
    min_size    = 3
    availability_zones = ["eu-west-1a"]
    # vpc_id      = "${module.}"

    launch_template {
    id      = "${aws_launch_template.centos_ws_template.id}"
    version = "$$Latest"
    }
    
    tags = [
        {
            key                 = "Name"
            value               = "Webserver1"
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
#   depends_on = ["aws_key_pair.global-ssh-key"]
  name                                  = "WebServerTemplate"
  description                           = "Contains base information for the creation of instances (web servers) through the asg."
  disable_api_termination               = true
  ebs_optimized                         = false
  image_id                              = "${var.custom_AMI}"
  instance_initiated_shutdown_behavior  = "terminate"
  key_name                              = "${aws_key_pair.global_ssh_key.key_name}"
  
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

  network_interfaces {
    associate_public_ip_address = true
  }
}

## This is only for demonstration purposes only!
## Implement differently for a production environment. 
resource "aws_key_pair" "global_ssh_key" {
    key_name   = "deployer-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCm1GjWH3Hs+bdSYqQ1bXsIkezdx1rtgv9P0jN98QelqTMRvA8GRi1daj4rXlBnKgc2MX02a+yn1pdT9oR6s67ALMLTfgZcgLPJs+AIDiCYUG2F2mF3skHf3di4p4uSKVGdzHZ9oG+YTXc4bd8+R1TQ3HqUSNRYfRGPa+oTblyCjJJFy8w2STsrsGaFuaEHpK8IvlVAkMqns4Hczhc9a9WavE+PdLCRMDWtdaV570UAv9+bt1C4jPQ/E/qEKqunsdVukyLLXujlv4s+WKLLRs3KPZ4YfT5vCtV7SU4LosHNdlsdERWlV43rUZJRO8RZ/o/QMDP912WHfigNzVdXNjj9 yordan@Dannys-Time-Machine"
}

# resource "aws_autoscaling_attachment" "attach_a_load_balancer" {
#   autoscaling_group_name = "${aws_autoscaling_group.WebServers.id}"
#   lb_target_group_arn   = "${}"
# }
