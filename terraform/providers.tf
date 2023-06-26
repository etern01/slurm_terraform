terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "y0_AgAAAAAA-ZwEAATuwQAAAADlOC_oLotY5k3XQzqdKKgcn4A4-eKk8JY"
  cloud_id  = "b1gn6ce1nonkpglv1qsl"
  folder_id = "b1gh4t6r8cg68emj1siq"
}

provider "tls" {
  proxy {
  }
}

provider "random" {
  # Configuration options
}

provider "local" {

}