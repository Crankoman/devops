resource "yandex_vpc_network" "devops_net" {
  name = "devops_net"
}

resource "yandex_vpc_subnet" "public-subnet-a" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.devops_net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "private-subnet-a" {
  name           = "private"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.devops_net.id
#  route_table_id = yandex_vpc_route_table.nat-route-table.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "public-subnet-b" {
  name           = "public"
  zone           = var.b_zone
  network_id     = yandex_vpc_network.devops_net.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}

resource "yandex_vpc_subnet" "private-subnet-b" {
  name           = "private"
  zone           = var.b_zone
  network_id     = yandex_vpc_network.devops_net.id
#  route_table_id = yandex_vpc_route_table.nat-route-table.id
  v4_cidr_blocks = ["192.168.40.0/24"]
}

resource "yandex_vpc_subnet" "public-subnet-c" {
  name           = "public"
  zone           = var.c_zone
  network_id     = yandex_vpc_network.devops_net.id
  v4_cidr_blocks = ["192.168.50.0/24"]
}

resource "yandex_vpc_subnet" "private-subnet-c" {
  name           = "private"
  zone           = var.c_zone
  network_id     = yandex_vpc_network.devops_net.id
#  route_table_id = yandex_vpc_route_table.nat-route-table.id
  v4_cidr_blocks = ["192.168.60.0/24"]
}
#resource "yandex_vpc_route_table" "nat-route-table" {
#  network_id = yandex_vpc_network.devops_net.id
#
#  static_route {
#    destination_prefix = "0.0.0.0/0"
#    next_hop_address   = var.nat-ip
#  }
#}
