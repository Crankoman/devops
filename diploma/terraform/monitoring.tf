# разворачиваем kube-prometheus 
resource "null_resource" "monitoring" {
  provisioner "local-exec" {
    command = "cd ../kube-prometheus/ && kubectl apply --server-side -f manifests/setup && kubectl wait --for condition=Established --all CustomResourceDefinition --namespace=monitoring && kubectl apply -f manifests/"
  }
  depends_on = [
    null_resource.kubeconfig_cp
  ]
}
# разворачиваем kube-prometheus сервис
resource "null_resource" "monitoring_service" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../k8s/service-grafana.yaml"
  }
  depends_on = [
    null_resource.monitoring
  ]
}