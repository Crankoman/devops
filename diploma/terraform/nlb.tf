# Создаем группу балансировщика
resource "yandex_lb_target_group" "networkbalancer-group" {
  name       = "networkbalancer-group"
  depends_on = [yandex_compute_instance_group.k8s-workers]
  dynamic "target" {
    for_each = yandex_compute_instance_group.k8s-workers.instances
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

# Создаем балансировщик grafana
resource "yandex_lb_network_load_balancer" "nlb-grafana" {
  name = "nlb-grafana"
  listener {
    name        = "grafana-listener"
    port        = 3000
    target_port = 30101
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.networkbalancer-group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 30101
      }
    }
  }
  depends_on = [yandex_lb_target_group.networkbalancer-group]
}

# Создаем балансировщик testapp
resource "yandex_lb_network_load_balancer" "nlb-testapp" {
  name = "nlb-testapp"
  listener {
    name        = "testapp-listener"
    port        = 80
    target_port = 30102
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.networkbalancer-group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 30102
      }
    }
  }
  depends_on = [yandex_lb_network_load_balancer.nlb-grafana]
}
