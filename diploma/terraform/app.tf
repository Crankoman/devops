# Развертываем приложение
resource "null_resource" "testapp_deployment" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/deployment-testapp.yaml"
  }
  depends_on = [
    null_resource.grafana_service
  ]
}
# Развертываем сервис приложение
resource "null_resource" "testapp_service" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/service-testapp.yaml"
  }
  depends_on = [
    null_resource.testapp_deployment
  ]
}
