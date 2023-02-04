provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZTMZSB2Z53J3CSHX"
  secret_key = "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"
}

resource "aws_instance" "Bam-Server" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  subnet_id = "subnet-06f3856545012c95b"

  tags = {
    Name = "Working-Server"
  }
}

resource "aws_vpc" "Bam-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "dbam"
  }
}

resource "aws_subnet" "Bam-subnet" {
  vpc_id            = aws_vpc.Bam-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "dbam"
  }
}

resource "aws_internet_gateway" "bam-igw" {
  vpc_id = aws_vpc.Bam-vpc.id

  tags = {
    Name = "dbam"
  }
}





