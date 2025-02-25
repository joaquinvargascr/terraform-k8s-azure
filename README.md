# Terraform Kubernetes Azure Project

This README provides a comprehensive guide for the project that uses Terraform to deploy infrastructure on Azure, including a Kubernetes cluster (AKS) and several associated resources.

## Project Structure

```
.env
.gitignore
.terraform/
providers/
registry.terraform.io/
hashicorp/
azurerm/
4.20.0/
darwin_arm64/
helm/
2.17.0/
darwin_arm64/
kubernetes/
2.35.1/
.terraform.lock.hcl
aks.tf
k8s.tf
locals.tf
main.tf
nginx-ingress.tf
output.tf
terraform-k8s-azure.code-workspace
terraform.tfstate
terraform.tfstate.backup
terraform.tfvars
variables.tf
```

## Description of Main Files

- **main.tf**: Defines the required providers (Azure, Kubernetes, Helm) and configures the AKS cluster, resource group, and other Azure resources such as Log Analytics Workspace and Application Insights.
  
- **aks.tf**: Configures the AKS cluster, including the node pool and integration with Log Analytics and Microsoft Defender.
  
- **k8s.tf**: Defines Kubernetes resources such as namespaces, pods (Nginx), and services.
  
- **nginx-ingress.tf**: Configures a Kubernetes Ingress resource for Nginx.
  
- **output.tf**: Defines important outputs of the project, such as cluster credentials, resource group name, and Application Insights keys.
  
- **variables.tf**: Defines the variables used in the project.
  
- **terraform.tfvars**: Provides values for the variables defined in `variables.tf`.
  
- **.env**: Contains the Azure credentials needed for authentication.

## Main Features

1. **AKS Deployment**: Uses the `azurerm_kubernetes_cluster` resource to create a Kubernetes cluster on Azure.
  
2. **Kubernetes Configuration**: Uses the Kubernetes provider to create namespaces, pods (Nginx), and services within the cluster.
  
3. **Azure Integration**: Configures additional resources such as Log Analytics Workspace and Application Insights for monitoring and analysis.
  
4. **Nginx Ingress**: Configures an Ingress resource for Nginx, allowing external access to applications deployed in the cluster.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Configuration

1. Clone the repository:

   ```sh
   git clone https://github.com/your-username/terraform-k8s-azure.git
   cd terraform-k8s-azure
   ```

2. Configure the variables in `terraform.tfvars`:

   ```hcl
   subscription_id     = "your_subscription_id"
   tenant_id           = "your_tenant_id"
   client_id           = "your_client_id"
   client_secret       = "your_client_secret"
   location            = "your_location"
   resource_group_name = "your_resource_group_name"
   aks_name            = "your_aks_name"
   ns_name             = "your_namespace_name"
   ```

## Deployment

1. Initialize Terraform:

   ```sh
   terraform init
   ```

2. Apply the configuration:

   ```sh
   terraform apply --auto-approve
   ```

## Outputs

Here are some of the important outputs generated:

```hcl
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log_workspace.id
}

output "application_insights_instrumentation_key" {
  value = azurerm_application_insights.app_insights.instrumentation_key
}
```

## Cleanup

To destroy the created resources, run:

```sh
terraform destroy --auto-approve
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.