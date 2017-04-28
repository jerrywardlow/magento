# Launch configuration
resource "aws_launch_configuration" "app" {
    name = "magento-app"
    image_id = "${var.app-ami}"
    instance_type = "${var.app-instance-type}"

    security_groups = ["${aws_security_group.app.id}"]
    key_name = "${aws_key_pair.magento.key_name}"

    user_data = "pass"

    lifecycle {
        create_before_destroy = true
    }
}
