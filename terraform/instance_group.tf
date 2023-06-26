data "yandex_compute_image" "this" {
  depends_on = [
    yandex_iam_service_account.sa
  ]
  folder_id = var.folder_id
  family = "centos-web-server"
}

resource "yandex_compute_instance_group" "this" {
  name                = var.instance_group_name
  folder_id           = var.folder_id
  service_account_id  = yandex_iam_service_account.sa.id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.this.id
        size     = 10
      }
    }
    network_interface {
      network_id = yandex_vpc_network.this.id
      nat = false
      subnet_ids =  ["${yandex_vpc_subnet.this["ru-central1-a"].id}","${yandex_vpc_subnet.this["ru-central1-b"].id}","${yandex_vpc_subnet.this["ru-central1-c"].id}"]
    }
    labels = var.labels
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  variables = {
    test_key1 = "test_value1"
    test_key2 = "test_value2"
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }
  application_load_balancer {
    target_group_name        = "target-group"
    target_group_description = "load balancer target group"
  }

  allocation_policy {
    zones = ["ru-central1-a","ru-central1-b","ru-central1-c"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 3
 
  }
  depends_on = [
    yandex_vpc_subnet.this,
    yandex_iam_service_account.sa,
    yandex_resourcemanager_folder_iam_binding.admin
  ]
}
