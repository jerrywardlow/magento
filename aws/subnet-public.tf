# Internet gateway for subnet
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

# Public subnets
resource "aws_subnet" "public" {
    count = 3 # Unable to inerpolate from AZ data source... for now...
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${lookup(var.public_cidr, count.index)}"
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    map_public_ip_on_launch = true
    depends_on = ["aws_internet_gateway.default"]
    tags {
        Name = "public-${count.index}"
    }
}
