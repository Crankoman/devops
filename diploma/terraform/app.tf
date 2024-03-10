# Развертываем приложение
resource "null_resource" "monitoring_service" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/deployment-testapp.yaml"
  }
  depends_on = [
    null_resource.monitoring
  ]
}
# Развертываем сервис приложение
resource "null_resource" "monitoring_service" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/service-testapp.yaml"
  }
  depends_on = [
    null_resource.monitoring
  ]
}