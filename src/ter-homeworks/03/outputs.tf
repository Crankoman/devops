output "all" {
  value = [for servers in local.servers_list : { name = servers["name"], id = servers["id"], fqdn = servers["fqdn"] }]
}