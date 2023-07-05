output "Grafana_URL" {
  value = "http://${aws_instance.prometheus_instance.public_ip}:3000"
}

output "Prometheus_URL" {
  value = "http://${aws_instance.prometheus_instance.public_ip}:9090"
}



