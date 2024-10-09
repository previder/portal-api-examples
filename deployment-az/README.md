# Deployment A-Z

Using the [Previder Terraform Provider](https://github.com/previder/terraform-provider-previder), deployments can be configured as Infrastructure as Code. This makes your setup scalable and you can manage your resources easy via GitOps.

Our provider is published on both the OpenTofu and Terraform registries. This enables the ease of using the code from any devoce anywhere without any programming skills or building binaries local on your system.

This manifest will deploy a maximum of 4 resources:
- Virtual Network `virtual-network`
- Virtual Firewall `virtual-firewall`
  - Internal Subnet of 10.10.10.1/24 
  - Linked to `virtual-network` 
  - NAT rule for the Kubernetes VIP
- Kubernetes Cluster
  - Linked to `virtual-network`
  - VIP of 10.10.10.2
  - Endpoint for SAN validity to `virtual-firewall` WAN IPv4 address
- STaaS environment
  - 1 Volume of 10GB
  - 1 Network linked to `virtual-network`

## OpenTofu vs Terraform
Both tools should work, but there are some differences. The main difference is the license structure. Sinds OpenTofu 1.8, they started to implement long awaited features like state encryption.

A good overview has been described on a SpaceLift blog: [OpenTofu vs Terraform : Key Differences and Comparison](https://spacelift.io/blog/opentofu-vs-terraform)

## Usage
There is a variables file to use to alter base variables.

In the provider.tf file, update your token, or use the PREVIDER_TOKEN environment variable to authenticate to the Previder Portal.

To use Previder STaaS, the network type must be VLAN. If this type has not been selected, then the storage configuration is ignored completely.

After the creation, the kubeconfig can be found via the command `tofu output kubeconfig`. Using this config, you can create your own `storage class` to get storage in the cluster.
See our [Kubernetes Examples repository](https://github.com/previder/kubernetes-examples) for more information.