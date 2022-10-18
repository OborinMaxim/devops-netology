terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.78.1"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "netology-graduate"
    region     = "ru-central1"
    key        = "testpath/terraform.tfstate"
    access_key = "YCAJE5Id18eAR5USvrrKTUBHu"
    secret_key = "YCPnh3EIpYDWW6LfNDkSYFgcLRS3Pg5b3sqHb1gk"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = var.yandex_cloud_id
  folder_id                = var.yandex_folder_id
  zone                     = "ru-central1-a"
}
