terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.27"
    }
  }

  #required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-north-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0bd13b2c265336401"
  instance_type = "t3.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }

  ##
  #monitoring = true
  metadata_options {
    http_endpoint = "disabled"
  }
  #ebs_optimized = true
  root_block_device {
    encrypted = true
  }
  iam_instance_profile = "demo-profile"
}


resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "echo Hello World!"
  }
}
