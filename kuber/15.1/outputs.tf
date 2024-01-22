output "nat-instance_ip" {
  value = yandex_compute_instance.nat-instance.network_interface.0.ip_address
}

output "nat-instance_nat_ip" {
  value = yandex_compute_instance.nat-instance.network_interface.0.nat_ip_address
}

output "public-instance_ip" {
  value = yandex_compute_instance.public-instance.network_interface.0.ip_address
}

output "public-instance_nat_ip" {
  value = yandex_compute_instance.public-instance.network_interface.0.nat_ip_address
}

output "private-instance_ip" {
  value = yandex_compute_instance.private-instance.network_interface.0.ip_address
}
