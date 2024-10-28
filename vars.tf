variable "REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-024e6efaf93d85776"
    us-east-2 = "ami-024e6efaf93d85776"
    us-east-3 = "ami-024e6efaf93d85776"
  }
}


variable "vpc" {
  default = "172.20.0.0/16"
}

variable "pubsub1" {
  default = "172.20.1.0/24"
}

variable "pubsub2" {
  default = "172.20.2.0/24"
}

variable "pubsub3" {
  default = "172.20.3.0/24"
}

variable "privsub1" {
  default = "172.20.4.0/24"
}

variable "privsub2" {
  default = "172.20.5.0/24"
}

variable "privsub3" {
  default = "172.20.6.0/24"
}

variable "az1" {
  default = "ap-south-1a"
}

variable "az2" {
  default = "ap-south-1b"
}

variable "az3" {
  default = "ap-south-1c"
}

variable "pub-key" {
  default = "tf-key.pub"
}