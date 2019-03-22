variable custom_AMI {}
variable server_max_count {}
variable server_min_count {}
variable web_server_instance_type {}
variable environment {}
variable webMainSec_id {}
variable vpc_id {}

variable public_key {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCm1GjWH3Hs+bdSYqQ1bXsIkezdx1rtgv9P0jN98QelqTMRvA8GRi1daj4rXlBnKgc2MX02a+yn1pdT9oR6s67ALMLTfgZcgLPJs+AIDiCYUG2F2mF3skHf3di4p4uSKVGdzHZ9oG+YTXc4bd8+R1TQ3HqUSNRYfRGPa+oTblyCjJJFy8w2STsrsGaFuaEHpK8IvlVAkMqns4Hczhc9a9WavE+PdLCRMDWtdaV570UAv9+bt1C4jPQ/E/qEKqunsdVukyLLXujlv4s+WKLLRs3KPZ4YfT5vCtV7SU4LosHNdlsdERWlV43rUZJRO8RZ/o/QMDP912WHfigNzVdXNjj9 yordan@Dannys-Time-Machine"
}
variable vpc_subs {
    type = "list"
}