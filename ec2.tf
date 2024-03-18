resource "aws_instance" "ec2-demo" {
    ami = "ami-0bb4c991fa89d4b9b"
    vpc_security_group_ids = [aws_security_group.sg-demo.id]
    instance_type = "t2.micro"
    key_name = aws_key_pair.ec2_key.key_name
    subnet_id = aws_subnet.private_subnet2.id
    user_data = file("install.sh")
    tags={
        Name = "Terraform-instance-1"
        env = "Dev"
    }

}
resource "aws_instance" "ec2-demo1" {
    ami = "ami-0bb4c991fa89d4b9b"
    vpc_security_group_ids = [aws_security_group.sg-demo.id]
    instance_type = "t2.micro"
    key_name = aws_key_pair.ec2_key.key_name
    subnet_id = aws_subnet.private_subnet1.id
    user_data = file("install.sh")
    tags={
        Name = "Terraform-instance-2"
        env = "Dev"
    }

}