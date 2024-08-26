# creating a keypair to access the server
resource "aws_key_pair" "dev_ec2_keypair" {
  public_key = var.public_key_value
  key_name   = var.public_key_name
}


# Launch template for auto scaling group
resource "aws_launch_template" "app_template" {
  name          = "DEV-Launch-Template"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.dev_ec2_keypair.key_name
  vpc_security_group_ids = [
    var.dev_server_sg_id
  ]
  user_data = filebase64("./scripts/dev_server_init.sh")
  tags = {
    Name = "Dev-App-Server"
  }
}

# auto scaling group resource for dev env servers
resource "aws_autoscaling_group" "dev_asg" {
  name                      = "DEV-Auto-Scaling_Group"
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  target_group_arns         = [var.dev_app_lb_tg]
  health_check_type         = "ELB"
  health_check_grace_period = 2000
  force_delete              = true
  vpc_zone_identifier       = var.private_subnet_ids
  launch_template {
    version = "$Latest"
    id      = aws_launch_template.app_template.id
  }
}
