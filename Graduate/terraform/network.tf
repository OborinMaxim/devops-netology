resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name           = "subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.101.0/24"]
  route_table_id = yandex_vpc_route_table.nat.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "nat" {
  network_id = yandex_vpc_network.default.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_dns_zone" "dns" {
  name   = "maxob-ru"
  zone   = "maxob.ru."
  public = true
}

resource "yandex_dns_recordset" "recordset_www" {
  zone_id = yandex_dns_zone.dns.id
  name    = "www.maxob.ru."
  type    = "A"
  ttl     = 200
  data = [
    yandex_compute_instance.nginx.network_interface.0.nat_ip_address
  ]
}

resource "yandex_dns_recordset" "recordset_gitlab" {
  zone_id = yandex_dns_zone.dns.id
  name    = "gitlab.maxob.ru."
  type    = "A"
  ttl     = 200
  data = [
    yandex_compute_instance.nginx.network_interface.0.nat_ip_address
  ]
}

resource "yandex_dns_recordset" "recordset_grafana" {
  zone_id = yandex_dns_zone.dns.id
  name    = "grafana.maxob.ru."
  type    = "A"
  ttl     = 200
  data = [
    yandex_compute_instance.nginx.network_interface.0.nat_ip_address
  ]
}

resource "yandex_dns_recordset" "recordset_prometheus" {
  zone_id = yandex_dns_zone.dns.id
  name    = "prometheus.maxob.ru."
  type    = "A"
  ttl     = 200
  data = [
    yandex_compute_instance.nginx.network_interface.0.nat_ip_address
  ]
}

resource "yandex_dns_recordset" "recordset_alertmanager" {
  zone_id = yandex_dns_zone.dns.id
  name    = "alertmanager.maxob.ru."
  type    = "A"
  ttl     = 200
  data = [
    yandex_compute_instance.nginx.network_interface.0.nat_ip_address
  ]
}
