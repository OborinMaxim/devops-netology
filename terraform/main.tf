terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.75.0"
    }
  }
}

provider "yandex" {
  token     = "$YC_TOKEN"
  cloud_id  = "b1g4cdi2a1ia53ar63ad"
  folder_id = "b1g5t45s7ep7fovc6bul"
  zone      = "ru-central1-a"
}

locals {
  web_instance_count_map = {
    stage = 1
    prod = 2
  }
}

resource "yandex_compute_image" "Ubuntu-count" {
  count = local.web_instance_count_map[terraform.workspace]

  name       = "Ubuntu_20.04_LTS-count-${count.index + 1}"
  source_url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
  description = "Ubuntu 20.04 LTS image for 07 module made through count"
  os_type = "LINUX"

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  instances = {
    stage = "1"
    prod = ["1", "2"]
  }
}

resource "yandex_compute_image" "Ubuntu-for-each" {
  for_each = toset(local.instances[terraform.workspace])

  name       = "Ubuntu_20.04_LTS-for-each-${each.value}"
  source_url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
  description = "Ubuntu 20.04 LTS image for 07 module made through for_each"
  os_type = "LINUX"
}
