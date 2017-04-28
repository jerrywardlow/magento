# Load balancer
resource "aws_elb" "app" {
    name = "${var.elb-name}"
    subnets = ["${aws_subnet.private.*.id}"]
    security_groups = ["${aws_security_group.elb.id}"]

    listener {
      instance_port = "${var.elb-instance-port}"
      lb_port = "${var.elb-lb-port}"
      instance_protocol = "${var.elb-instance-protocol}"
      lb_protocol = "${var.elb-lb-protocol}"
    }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 5
      timeout = 5
      target = "HTTP:80/"
      interval = 10
    }

    tags {
        group = "mage-elb"
    }
}
