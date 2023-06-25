locals {
  ssh_keys_and_serial_port = {
    ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    serial-port-enable = 1
  }
}
locals {
  servers_list = {[for i in yandex_compute_instance.webs : i],
[for i in yandex_compute_instance.redis : i],
[for i in yandex_compute_instance.storage : i]]}
}