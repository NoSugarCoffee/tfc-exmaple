# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "tencentcloud_mysql_instance" "mysql" {
      mem_size          = 16000
      cpu               = 4
      volume_size       = 50
      charge_type       = "PREPAID"
      instance_name     = "testAccMysql"
      engine_version    = "5.5"
      root_password     = "test1234"
      availability_zone = var.availability_zone
      internet_service  = 1
      intranet_port     = 3360
      prepaid_period    = 1
    tags = {
       purpose = "for test"
   }
    parameters = {
       max_connections = "1000"
   }
   count = 1
}
