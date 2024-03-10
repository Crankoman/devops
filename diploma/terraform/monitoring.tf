# разворачиваем kube-prometheus 
resource "null_resource" "grafana_deployment" {
  provisioner "local-exec" {
    command = "cd ../kube-prometheus/ && kubectl apply --server-side -f manifests/setup && kubectl wait --for condition=Established --all CustomResourceDefinition --namespace=monitoring && kubectl apply -f manifests/"
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
