resource "yandex_vpc_network" "devops_net" {
  name = "devops_net"
}

resource "yandex_vpc_subnet" "public-subnet" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.devops_net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "private-subnet" {
  name           = "private"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.devops_net.id
  route_table_id = yandex_vpc_route_table.nat-route-table.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_route_table" "nat-route-table" {
  network_id = yandex_vpc_network.devops_net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat-ip
  }
}
