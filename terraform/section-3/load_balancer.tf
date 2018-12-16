resource "aws_lb" "apache" {
  name = "my-first-alb"
  load_balancer_type = "application"
  security_groups = [
    "${aws_security_group.elb.id}"]
  subnets = [
    "${aws_default_subnet.subnets.*.id}"]
  internal = false
  idle_timeout = 60

  tags {
    Name = "my-first-alb"
  }
}

resource "aws_lb_target_group" "apache" {
  name = "apache"
  port = 80
  protocol = "HTTP"

  stickiness {
    type = "lb_cookie"
    cookie_duration = 1800
    enabled = true
  }

  health_check {
    healthy_threshold = 10
    unhealthy_threshold = 3
    interval = 10
    timeout = 5
    path = "/"
    port = 80
  }
  vpc_id = "${aws_default_vpc.vpc.id}"
}

resource "aws_alb_listener" "apache" {
  load_balancer_arn = "${aws_lb.apache.arn}"
  port = "80"
  protocol = "HTTP"
  "default_action" {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.apache.arn}"
  }
}

resource "aws_autoscaling_attachment" "apache" {
  alb_target_group_arn = "${aws_lb_target_group.apache.arn}"
  autoscaling_group_name = "${aws_autoscaling_group.apache.name}"
}

