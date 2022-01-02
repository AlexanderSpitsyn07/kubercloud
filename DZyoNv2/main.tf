terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = "AQAAAAAefdy5AATuwUeJe6fYhksSlpt6TzfD4bI"
  cloud_id  = "b1ghmgr7u88nv3sior28"
  folder_id = "b1gknvocj54h5e6sh9ho"
  zone      = "ru-central1-b"
}

resource "yandex_vpc_network" "myvpc1" {
  name = "myvpc1"
  description = "myvpc"
}

resource "yandex_vpc_subnet" "public" {
  name = "public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.myvpc1.id
  description = "public"
}

resource "yandex_vpc_subnet" "private" {
  name = "private"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.myvpc1.id
  description = "private"
}

resource "yandex_compute_instance" "nat-instance" {
  name        = "mynat"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
  }

  metadata = {
    ssh-keys = "alexander:${file("~/.ssh/yac.pub")}"
  }
}

resource "yandex_vpc_route_table" "my-rt-a" {
  name = "route1"
  network_id = yandex_vpc_network.myvpc1.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}


