resource "yandex_compute_instance_group" "k8s-masters" {
  name               = "k8s-masters"
  service_account_id = "ajenrs1pkbilhtdoi0sd"
  depends_on = [
    yandex_vpc_network.net,
    yandex_vpc_subnet.central1-a,
    yandex_vpc_subnet.central1-b,
    yandex_vpc_subnet.central1-d,
  ]

  instance_template {
    platform_id = "standard-v2"
    name        = "master-{instance.index}"

    resources {
      cores         = var.vm_resources.master.cores
      memory        = var.vm_resources.master.memory
      core_fraction = var.vm_resources.master.core_fraction
    }

    boot_disk {
      initialize_params {
        image_id = "fd8vmcue7aajpmeo39kk" # Ubuntu 20.04 LTS
        size     = 10
        type     = "network-ssd"
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
      ssh-keys = "devops:${file("~/.ssh/id_rsa.pub")}"
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
