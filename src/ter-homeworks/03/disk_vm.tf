resource "yandex_compute_disk" "disk" {
  count = 3
  name  = "disk-${count.index}"
  type  = "network-hdd"
  zone  = var.default_zone
  size  = 1
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  dynamic secondary_disk {
    for_each = yandex_compute_disk.disk
    content {
      disk_id     = yandex_compute_disk.disk[secondary_disk.key].id
    }
  }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.ssh_keys_and_serial_port
}