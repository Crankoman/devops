# Запускаем GitLab Runner в k8s
resource "null_resource" "grafana_service" {
  provisioner "local-exec" {
    command = "helm repo add gitlab https://charts.gitlab.io && helm repo update && helm upgrade --install gitlab-agent gitlab/gitlab-agent --namespace gitlab-agent-gitlab-agent --create-namespace --set image.tag=v16.10.1 --set config.token=glagent-NaLnCb3YuqDvTJJA2Cr_a1oteKLLe-6xy2gVsczQ7RaLJzkaHw --set config.kasAddress=wss://kas.gitlab.com"
  }
  depends_on = [
    null_resource.grafana_service
  ]
}



 
