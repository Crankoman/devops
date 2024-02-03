#
#resource "yandex_iam_service_account" "sa1" {
#  folder_id = var.folder_id
#  name      = "tf-test1-sa"
#}
#
#resource "yandex_resourcemanager_folder_iam_member" "sa-editor1" {
#  folder_id = var.folder_id
#  role      = "editor"
#  member    = "serviceAccount:${yandex_iam_service_account.sa1.id}"
#}
#
#resource "yandex_compute_instance_group" "cig-1" {
#  name               = "cig-1"
#  folder_id          = var.folder_id
#  service_account_id = yandex_iam_service_account.sa1.id
#
#
#  instance_template {
#    platform_id = var.vm_platform_id
#    resources {
#      cores         = var.vm_resources.cpu_cores
#      memory        = var.vm_resources.memory
#      core_fraction = var.vm_resources.core_fraction
#    }
#    boot_disk {
#      mode = "READ_WRITE"
#      initialize_params {
#        image_id = var.vm_image_lamp
#      }
#    }
#    network_interface {
#      subnet_ids = [
#        yandex_vpc_subnet.public-subnet.id
#      ]
#      nat = true
#    }
#    metadata = {
#      ssh-keys  = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
#      user-data = <<EOF
##!/bin/bash
#apt install httpd -y
#cd /var/www/html
#echo '<html><img src="http://${yandex_storage_bucket.test-bucket.bucket_domain_name}/sample-clouds-400x300.jpg"/></html>'  > index.html
#service httpd start
#EOF
#    }
#    network_settings {
#      type = "STANDARD"
#    }
#  }
#
#  scale_policy {
#    fixed_scale {
#      size = 3
#    }
#  }
#
#  allocation_policy {
#    zones = [var.default_zone]
#  }
#
#  deploy_policy {
#    max_unavailable = 1
#    max_creating    = 3
#    max_expansion   = 1
#    max_deleting    = 1
#  }
#  health_check {
#    http_options {
#      port = 80
#      path = "/"
#    }
#  }
#  load_balancer {
#    target_group_name = "target-group"
#  }
#  depends_on = [
#    yandex_storage_bucket.test-bucket
#  ]
#}
#