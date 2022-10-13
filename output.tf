

output "arn" {
  value = aws_instance.ec2_instance.arn
}

output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}