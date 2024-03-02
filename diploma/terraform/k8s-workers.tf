resource "yandex_compute_instance_group" "k8s-workers" {
  name               = "k8s-workers"
  service_account_id = "ajenrs1pkbilhtdoi0sd"
  depends_on = [
    yandex_compute_instance_group.k8s-masters
  ]

  instance_template {
    platform_id = "standard-v2"
    name        = "worker-{instance.index}"

    resources {
      cores         = var.vm_resources.worker.cores
      memory        = var.vm_resources.worker.memory
      core_fraction = var.vm_resources.worker.core_fraction
    }

    boot_disk {
      initialize_params {
        image_id = "fd8vmcue7aajpmeo39kk" # Ubuntu 20.04 LTS
        size     = 10
        type     = "network-hdd"
      }
    }

    network_interface {
      network_id = yandex_vpc_network.net.id
      subnet_ids = [
        yandex_vpc_subnet.central1-a.id,
        yandex_vpc_subnet.central1-b.id,
        yandex_vpc_subnet.central1-d.id,
      ]
      nat = true
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }

    scheduling_policy {
      preemptible = true
    }


    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [
      var.a_zone,
      var.b_zone,
      var.d_zone,
    ]
  }

  deploy_policy {
    max_unavailable = 3
    max_creating    = 3
    max_expansion   = 3
    max_deleting    = 3
  }
}
