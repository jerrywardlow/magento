# Private subnets
resource "aws_subnet" "private" {
    count = 3
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${lookup(var.private_cidr, count.index)}"
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    map_public_ip_on_launch = false
    tags {
        Name = "private-${count.index}"
    }
}

# Routing table and association
resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "pass"
    }
}

resource "aws_route_table_association" "private" {
    count = 3
    subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id = "${aws_route_table.private.id}"
}
