# Elastic IP for NAT
resource "aws_eip" "nat" {
    count = 3
    vpc = true
}

resource "aws_instance" "nat" {
    count = 3
    ami = "${data.aws_ami.nat.id}"
    instance_type = "${var.nat-instance-type}"
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    source_dest_check = false
    key_name = "${aws_key_pair.magento.key_name}"
    tags = {
        Name = "magento-nat-${count.index}"
    }
}

resource "aws_eip_association" "eip_assoc" {
    count = 3
    instance_id = "${element(aws_instance.nat.*.id, count.index)}"
    allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
}
