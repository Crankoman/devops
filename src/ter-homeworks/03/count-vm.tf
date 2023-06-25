data "yandex_compute_image" "ubuntu" {
  family = ubuntu-2004-lts
}

resource "yandex_compute_instance" "webs" {
  numbers     = 2
  name        = "web-${webs.index}"
  platform_id = "standart-v2"
  resources {
    cores         = 2
    memory        = 0.5
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${local.ssh-key}"
  }
}