variable "custom_AMI" {
    default = "ami-0ff760d16d9497662"
}
variable "server_max_count" {
    default = 0
}
variable "server_min_count" {
    default = 0
}
variable "web_server_instance_type" {
    default = "t2.micro"
}
variable "environment" {
    default = "dev"
}
