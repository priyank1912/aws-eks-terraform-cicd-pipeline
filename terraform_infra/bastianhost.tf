resource "aws_instance" "bastianhost" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  key_name                    = "bastianhostkey"
  subnet_id                   = module.rdsvpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastianhost_sg.id]
  tags = {
    Name    = "bastionhost",
    purpose = "priyank-personal-project"
  }
}