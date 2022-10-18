output "internal_ip_address_nginx_node_yandex_cloud" {
  value = yandex_compute_instance.nginx.network_interface.0.ip_address
}

output "external_ip_address_nginx_node_yandex_cloud" {
  value = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
}

output "internal_ip_address_mysql_master_node_yandex_cloud" {
  value = yandex_compute_instance.mysql1.network_interface.0.ip_address
}

output "internal_ip_address_mysql_slave_node_yandex_cloud" {
  value = yandex_compute_instance.mysql2.network_interface.0.ip_address
}

output "internal_ip_address_wordpress_node_yandex_cloud" {
  value = yandex_compute_instance.wordpress.network_interface.0.ip_address
}

output "internal_ip_address_gitlab_ce_node_yandex_cloud" {
  value = yandex_compute_instance.gitlabce.network_interface.0.ip_address
}

output "internal_ip_address_gitlab_runner_node_yandex_cloud" {
  value = yandex_compute_instance.gitlabrun.network_interface.0.ip_address
}

output "internal_ip_address_monitoring_node_yandex_cloud" {
  value = yandex_compute_instance.monitoring.network_interface.0.ip_address
}
