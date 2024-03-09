# разворачиваем kube-prometheus 
resource "null_resource" "monitoring" {
  provisioner "local-exec" {
    command = "cd ../kube-prometheus/ && kubectl apply --server-side -f manifests/setup && kubectl wait --for condition=Established --all CustomResourceDefinition --namespace=monitoring && kubectl apply -f manifests/"
  }
  depends_on = [
    null_resource.kubeconfig_cp
  ]
}