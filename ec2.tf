#https://cloudinfrastructureservices.co.uk/how-to-create-linux-aws-ec2-instance-using-terraform/
#ssh -i ~/.ssh/aws ec2-user@38.200.209.127
resource "aws_key_pair" "key" {
  key_name   = "login_key"
  public_key = file("~/.ssh/aws.pub")
}


resource "aws_default_vpc" "default_vpc" {

}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"


  # using default VPC
  vpc_id = aws_default_vpc.default_vpc.id

  ingress {
    description = "TLS from VPC"

    # we should allow incoming and outoging
    # TCP packets
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    # allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0f924dc71d44d23e2"
  instance_type = "t2.micro"

  # refering key which we created earlier
  key_name = aws_key_pair.key.key_name

  # refering security group created earlier
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    "Name" = "AmazonLinux"
  }
}

