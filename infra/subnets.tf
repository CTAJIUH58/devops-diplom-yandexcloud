resource "yandex_vpc_network" "my_vpc" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public_subnet" {
  count = length(var.public_subnet_zones)
  name  = "${var.public_subnet_name}-${count.index}"
  v4_cidr_blocks = [
    var.public_v4_cidr_blocks[count.index] 
  ]
  zone       = var.public_subnet_zones[count.index]
  network_id = yandex_vpc_network.my_vpc.id
}



