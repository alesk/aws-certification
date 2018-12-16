resource "aws_default_vpc" "vpc" {

}

resource "aws_default_subnet" "subnets" {
  count = "${length(var.AVAILABILITY_ZONES)}"
  availability_zone = "${element(var.AVAILABILITY_ZONES, count.index)}"
}

