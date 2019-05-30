output "Grafana URL" {
  value = "http://${aws_instance.prometheus_instance.public_ip}:3000"
}

output "Prometheus URL" {
  value = "http://${aws_instance.prometheus_instance.public_ip}:9090"
}



