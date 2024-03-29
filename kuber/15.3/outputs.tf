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
#output "ipaddress_group-nlb" {
#  value = yandex_compute_instance_group.group-nlb.instances[*].network_interface[0].ip_address
#}
#output "nlb_address" {
#  value = yandex_lb_network_load_balancer.nlb.listener.*.external_address_spec[0].*.address
#}
output "picture_url" {
  value = "https://${yandex_storage_bucket.test-bucket.bucket_domain_name}"
}
