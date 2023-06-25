resource "yandex_compute_disk" "develop" {
  count = 3
  name  = "disk_vm-${count.index}"
  type  = "network-hdd"
  size  = 1
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 0.5
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.develop
    content {
      disk_id     = secondary_disk.value.id
      auto_delete = true
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