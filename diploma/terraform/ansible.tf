# Копируем конфиг

resource "null_resource" "kubespray_init" {
  provisioner "local-exec" {
    command = "cp -r ../ansible/kubespray/inventory/sample/. ../ansible/kubespray/inventory/k8s"
  }
}


# готовим inventory для kubesprey
resource "local_file" "inventory" {
  content = templatefile("template/inventory.tftpl", {
    all_nodes = flatten([
      [for v in yandex_compute_instance_group.k8s-masters.instances : [v.network_interface.0.ip_address, v.network_interface.0.nat_ip_address]],
      [for v in yandex_compute_instance_group.k8s-workers.instances : [v.network_interface.0.ip_address, v.network_interface.0.nat_ip_address]]
    ])
    masters = [for v in yandex_compute_instance_group.k8s-masters.instances : [v.network_interface.0.ip_address, v.network_interface.0.nat_ip_address]]
    workers = [for v in yandex_compute_instance_group.k8s-workers.instances : [v.network_interface.0.ip_address, v.network_interface.0.nat_ip_address]]
  })
  filename = "../ansible/kubespray/inventory/k8s/inventory.ini"
  depends_on = [
    null_resource.kubespray_init,
    yandex_compute_instance_group.k8s-masters,
    yandex_compute_instance_group.k8s-workers
  ]
}

# пробрасываем параметр kubeconfig_localhost в kubespray что бы настроить kubeconfig

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "echo 'kubeconfig_localhost: true' >> ../ansible/kubespray/inventory/k8s/group_vars/k8s_cluster/k8s-cluster.yml"
  }
  depends_on = [
    local_file.inventory
  ]
}



# проверяем что поднялся 3-й мастер
resource "null_resource" "timeout_k8s_start_masters" {
  depends_on = [
    null_resource.kubeconfig
  ]

  provisioner "local-exec" {
    command = "while ! nc -z ${yandex_compute_instance_group.k8s-masters.instances.2.network_interface.0.nat_ip_address}   22; do sleep   5; done"
  }
}

# проверяем что поднялся 3-й воркер
resource "null_resource" "timeout_k8s_start_workers" {
  depends_on = [
    null_resource.timeout_k8s_start_masters
  ]

  provisioner "local-exec" {
    command = "while ! nc -z ${yandex_compute_instance_group.k8s-workers.instances.2.network_interface.0.nat_ip_address}   22; do sleep   5; done"
  }
}

# запускаем kubesprey
resource "null_resource" "ansible_provisioner" {
  depends_on = [
    null_resource.timeout_k8s_start_masters,
    null_resource.timeout_k8s_start_workers,
  ]

  provisioner "local-exec" {
    command = "cd ../ansible/kubespray && ansible-playbook -i inventory/k8s/inventory.ini cluster.yml -b -v"
  }
}
