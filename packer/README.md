# Terraform Configuration

This repository contains Terraform configuration for setting up a Yandex infrastructure with a web server.

## Variables

The following variables can be configured:

### image_tag

- **Type:** string

## Yandex Source Configuration

The Yandex source configuration is defined as follows:

```hcl
source "yandex" "webserver" {
  folder_id           = "b1g5reegu63oulupmm6s"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  token               = ""
  use_ipv4_nat        = "true"
  image_name          = "nginx-${var.image_tag}"
  image_family        = "centos-web-server"
  image_description   = "my custom debian with nginx"
}


