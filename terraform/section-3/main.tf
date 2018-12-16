provider "aws" {
  region = "eu-west-1"
  profile = "${var.AWS_PROFILE}"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}

variable "AWS_PROFILE" {
  default = "serverless"
}

variable "AVAILABILITY_ZONES" {
  type = "list"
  default = [
    "eu-west-1a",
    "eu-west-1b"]
}

resource "aws_key_pair" "key" {
  key_name = "ultimate-windows"
  public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}


resource "aws_launch_configuration" "apache" {
  image_id = "ami-09693313102a30b2c"
  instance_type = "t2.micro"
  user_data = "${file("data/init.sh")}"
  key_name = "${aws_key_pair.key.key_name}"
  security_groups = [
    "${aws_security_group.ssh.id}",
    "${aws_security_group.http.id}"]

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "apache" {
  launch_configuration = "${aws_launch_configuration.apache.name}"
  name = "apache"
  vpc_zone_identifier = [
    "${aws_default_subnet.subnets.*.id}"]
  min_size = 2
  max_size = 2

  target_group_arns = ["${aws_lb_target_group.apache.arn}"]

  tag {
    key = "Name"
    value = "autoscale"
    propagate_at_launch = true
  }
}