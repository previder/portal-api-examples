output "kube_config" {
  depends_on = [previder_kubernetes_cluster.cluster[0]]
  value = previder_kubernetes_cluster.cluster[0].kubeconfig
}

output "wan_address_ipv4" {
  depends_on = [previder_virtual_firewall.firewall]
  value = previder_virtual_firewall.firewall[0].wan_address[0]
}