# разворачиваем kube-prometheus 
resource "null_resource" "grafana_deployment" {
  provisioner "local-exec" {
    command = "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update && helm install prometheus-stack  prometheus-community/kube-prometheus-stack"
  }
  depends_on = [
    null_resource.ansible_provisioner
  ]
}

# разворачиваем kube-prometheus сервис
resource "null_resource" "grafana_service" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/service-grafana.yaml"
  }
  depends_on = [
    null_resource.grafana_deployment
  ]
}
