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

resource "yandex_compute_image" "Ubuntu" {
  name       = "Ubuntu_20.04_LTS"
  source_url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
  description = "Ubuntu 20.04 LTS image for 07 module"
  os_type = "LINUX"
}
