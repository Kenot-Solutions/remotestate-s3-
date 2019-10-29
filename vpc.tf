resource "aws_vpc" "tf_vpc" {
    cidr_block ="10.0.0.0/16"
    enable_dns_support=true
   
    tags = {
        name ="VPC Name"
        Whatfor="test"
    }
}


resource "aws_subnet" "public-1" {
    availability_zone="us-west-1a"
    vpc_id ="${aws_vpc.tf_vpc.id}"
    cidr_block ="10.0.1.0/24"
    map_public_ip_on_launch =true
}

resource "aws_subnet" "private-1" {
    availability_zone="us-west-1a"
    vpc_id ="${aws_vpc.tf_vpc.id}"
    cidr_block ="10.0.2.0/24"
    map_public_ip_on_launch =false


}


resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags = {
    Name = "tf_igw"
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_internet_gateway.id}"
  }

  tags = {
    Name = "tf_public"
  }
}

resource "aws_route_table_association" "tf_public_assoc" {
  subnet_id      = "${aws_subnet.public-1.id}"
  route_table_id = "${aws_route_table.tf_public_rt.id}"
}



# nat gw
resource "aws_eip" "nat" {
  vpc      = true
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${aws_subnet.public-1.id}"
  depends_on = ["aws_internet_gateway.tf_internet_gateway"]
}

# VPC setup for NAT
resource "aws_route_table" "tf_private_rt" {
    vpc_id = "${aws_vpc.tf_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
    }

    tags = {
        Name = "private-1"
    }
}

# route associations private
resource "aws_route_table_association" "main-private-1-a" {
    subnet_id = "${aws_subnet.private-1.id}"
    route_table_id = "${aws_route_table.tf_private_rt.id}"
}
