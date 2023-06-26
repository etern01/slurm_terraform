resource "yandex_alb_http_router" "this" {
  name      = "my-http-router"
  folder_id = var.folder_id
  labels = var.labels
}


resource "yandex_alb_load_balancer" "this" {
  name        = "my-load-balancer"
  folder_id = var.folder_id
  network_id  = "${yandex_vpc_network.this.id}"

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = "${yandex_vpc_subnet.this["ru-central1-a"].id}" 
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }

  # log_options {
  #   discard_rule {
  #     http_code_intervals = ["HTTP_2XX"]
  #     discard_percent = 75
  #   }
  # }
}


resource "yandex_alb_backend_group" "this" {
  name      = "my-backend-group"

  http_backend {
    name = "test-http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_compute_instance_group.this.application_load_balancer[0].target_group_id}"]
    # tls {
    #   sni = "backend-domain.internal"
    # }
    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck {
      timeout = var.healthcheck-lb.timeout
      interval = var.healthcheck-lb.interval
      http_healthcheck {
        path  = var.healthcheck-lb.path
      }
    }
    http2 = "true"
  }
}


resource "yandex_alb_virtual_host" "this" {
  name           = "alb-host"
  http_router_id = yandex_alb_http_router.this.id
  authority      = ["${yandex_alb_load_balancer.this.listener[0].endpoint[0].address[0].external_ipv4_address[0].address}"]
  route {
    name = "route-1"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
      }
    }
  }
}