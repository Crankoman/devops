# проверяем что поднялся 3-й мастер
resource "null_resource" "timeout_k8s_start_masters" {
  depends_on = [
    yandex_compute_instance_group.k8s-masters
  ]

  provisioner "local-exec" {
    command = "while ! nc -z ${yandex_compute_instance_group.k8s-masters.instances.2.network_interface.0.nat_ip_address}   22; do sleep   5; done"
  }
}

# проверяем что поднялся 3-й воркер
resource "null_resource" "timeout_k8s_start_workers" {
  depends_on = [
    yandex_compute_instance_group.k8s-workers
  ]

  provisioner "local-exec" {
    command = "while ! nc -z ${yandex_compute_instance_group.k8s-workers.instances.2.network_interface.0.nat_ip_address}   22; do sleep   5; done"
  }
}


# Копируем конфиг
resource "null_resource" "kubespray_init" {
  provisioner "local-exec" {
    command = "cp -rfp ../ansible/kubespray/inventory/sample/. ../ansible/kubespray/inventory/mycluster"
  }
}

# наполняем inventory для kubesprey
resource "local_file" "inventory" {
  content = templatefile("template/inventory.tftpl", {
    all_nodes = flatten([
      [for v in yandex_compute_instance_group.k8s-masters.instances : [v.network_interface.0.ip_address, v.network_interface.0.nat_ip_address]],
      [for v in yandex_compute_instance_group.k8s-workers.instances : [v.network_interface.0.ip_address, v.network_interface.0.nat_ip_address]]
    ])
    masters = [for v in yandex_compute_instance_group.k8s-masters.instances : [v.network_interface.0.ip_address, v.network_interface.0.nat_ip_address]]
    workers = [for v in yandex_compute_instance_group.k8s-workers.instances : [v.network_interface.0.ip_address, v.network_interface.0.nat_ip_address]]
  })
  filename = "../ansible/kubespray/inventory/mycluster/inventory.ini"
  depends_on = [
    null_resource.kubespray_init,
    null_resource.timeout_k8s_start_masters,
    null_resource.timeout_k8s_start_workers
  ]
}

# пробрасываем параметр kubeconfig_localhost в kubespray, что бы настроить kubeconfig
resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "cd ../ansible/kubespray/inventory/mycluster/group_vars/k8s_cluster/ && echo '\nkubeconfig_localhost: true\nkubeconfig_localhost_ansible_host: true\nkubectl_localhost: true' >> k8s-cluster.yml"
  }
  depends_on = [
    local_file.inventory
  ]
}

# передаем внешний ip мастернод для подключения из вне
resource "null_resource" "supplementary_addresses" {
  provisioner "local-exec" {
    command = "cd ../ansible/kubespray/inventory/mycluster/group_vars/k8s_cluster/ && echo 'supplementary_addresses_in_ssl_keys: [ ${yandex_compute_instance_group.k8s-masters.instances.0.network_interface.0.nat_ip_address} ]' >> k8s-cluster.yml"
  }
  depends_on = [
    null_resource.kubeconfig
  ]
}



# запускаем kubesprey
resource "null_resource" "ansible_provisioner" {
  provisioner "local-exec" {
    command = "cd ../ansible/kubespray && ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml --become --become-user=root -vv"
  }
    depends_on = [
    null_resource.supplementary_addresses,
  ]
}

# копируем kubeconfig
resource "null_resource" "kubeconfig_cp" {
  provisioner "local-exec" {
    command = "mkdir -p ~/.kube && cp ../ansible/kubespray/inventory/mycluster/artifacts/admin.conf ~/.kube/config"
  }
  depends_on = [
    null_resource.ansible_provisioner
  ]
}