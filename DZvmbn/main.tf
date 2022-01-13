terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = "121212121212"
  cloud_id  = "12121212"
  folder_id = "12121212"
  zone      = "ru-central1-b"
}

resource "yandex_storage_bucket" "ocelotik-bucket" {
  access_key = "xQav967HDnMY3tRhkeyc"
  secret_key = "dIwBYrM4rk-9wtk5Pezc9efMx2iqZlovDsj-46EP"
  bucket = "ocelotik-bucket"
}

resource "yandex_storage_object" "picture-object" {
  access_key = "xQav967HDnMY3tRhkeyc"
  secret_key = "dIwBYrM4rk-9wtk5Pezc9efMx2iqZlovDsj-46EP"
  bucket = "ocelotik-bucket"
  key    = "Tarja"
  source = "~/111.jpg"
}

resource "yandex_compute_instance_group" "mg-1" {
  name               = "mg-1"
  folder_id          = "b1gknvocj54h5e6sh9ho"
  service_account_id = "ajedh2sj51f5alg9100m"
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }

    network_interface {
      network_id = "enph597mp30hajmckp05"
      subnet_ids = ["e2liq5oj77mu7qd5rv2t"]
    }

    metadata = {
        user-data  = "${file("/home/alexander/netology/block5/152/meta.txt")}"
    }

  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

allocation_policy {
    zones = ["ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion = 0
  }
}

resource "yandex_lb_network_load_balancer" "my-network-load-balancer" {
  name = "my-network-load-balancer"

  listener {
    name = "my-listener"
    port = 8080
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "enp5pjljtvpp22ujvv7t"

    healthcheck {
      name = "http"
      http_options {
        port = 8080
        path = "/ping"
      }
    }
  }
}
