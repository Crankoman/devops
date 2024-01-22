variable "redis_vars" {
  type = list(object({
    vm_name   = string
    cpu       = number
    ram       = number
    disk      = number
    core_frac = number
  }))
  default = [
    {
      vm_name   = "main"
      cpu       = 4
      ram       = 1
      disk      = 5
      core_frac = 5
    }, {
      vm_name   = "replica"
      cpu       = 2
      ram       = 0.5
      disk      = 10
      core_frac = 10
    },
  ]
}


resource "yandex_compute_instance" "redis" {

  depends_on = [yandex_compute_instance.webs]

  for_each    = {for vm in var.redis_vars : vm.vm_name => vm}
  platform_id = "standard-v2"
  name        = each.value.vm_name

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_frac
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = each.value.disk
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
