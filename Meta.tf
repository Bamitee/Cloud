provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZTMZSB2Z53J3CSHX"
  secret_key = "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"
}



variable "vpc_cidr" {

    default = "10.0.0.0/16"  
}

variable "subnets_cidr" {

    type = list
    default = ["10.0.1.0/24" , "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]  
}

variable "availability_zones" {

    type = list
    default = ["us-east-1a" , "us-east-1a" , "us-east-1b","us-east-1b"] 
 
}

resource "aws_vpc" "vpc" {

    cidr_block = var.vpc_cidr


    tags = {

        Name = "Meta-vpc"
    }

}


resource "aws_subnet" "sbnt" {

    count  = length(var.subnets_cidr) 
                                        
  vpc_id = aws_vpc.vpc.id

    cidr_block              = element(var.subnets_cidr , count.index) 
    availability_zone       = element(var.availability_zones , count.index)
    map_public_ip_on_launch = true


    tags = {

        Name = "My-Subnet-${count.index + 1}"
    }

}


resource "aws_internet_gateway" "igw" {

    vpc_id = aws_vpc.vpc.id


    tags = {

        Name = "Meta-IGW"
    }

}


resource "aws_route_table" "rt" {

    vpc_id = aws_vpc.vpc.id
    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }


    tags = {

        Name = "Meta-Public-R-T"
    }

}

resource "aws_instance" "EC2" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  subnet_id = "subnet-051a49ebf188353e6"

  tags = {
    Name = "Meta-Server"
  }
}




