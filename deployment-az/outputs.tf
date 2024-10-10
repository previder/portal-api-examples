output "kube_config" {
  depends_on = [module.deployment.kube_config]
  value = module.deployment.kube_config
  sensitive = true
}

output "wan_address_ipv4" {
  value = module.deployment.wan_address_ipv4
}