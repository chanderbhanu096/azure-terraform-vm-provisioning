# Azure Terraform Demo

A Terraform project that provisions a complete Azure infrastructure including a Linux virtual machine with networking components in West Europe.

## 📋 Project Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform to deploy a production-ready Ubuntu VM on Azure. It includes all necessary networking components, security configurations, and SSH access setup.

## 🏗️ Infrastructure Components

The Terraform configuration creates the following Azure resources:

- **Resource Group**: Container for all resources
- **Virtual Network (VNet)**: Network with address space `11.0.0.0/16`
- **Subnet**: Internal subnet with range `11.0.1.0/24`
- **Network Security Group (NSG)**: Firewall rules allowing SSH access (port 22)
- **Public IP Address**: Static public IP with Standard SKU
- **Network Interface**: Connects VM to the virtual network
- **Linux Virtual Machine**: Ubuntu 22.04 LTS (Jammy) with custom initialization

## 🚀 Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 3.0)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription with appropriate permissions

### Azure Authentication

1. Login to Azure:
   ```bash
   az login
   ```

2. Set your subscription (if you have multiple):
   ```bash
   az account set --subscription "your-subscription-id"
   ```

### SSH Key Setup

1. The project expects an SSH key pair in the project directory:
   - Private key: `id_rsa_terraform_demo`
   - Public key: `id_rsa_terraform_demo.pub`

2. If you need to generate a new SSH key pair:
   ```bash
   ssh-keygen -t rsa -b 4096 -f id_rsa_terraform_demo -C "your-email@example.com"
   ```

   **⚠️ Important**: Make sure to add `id_rsa_terraform_demo` to your `.gitignore` to avoid committing private keys!

## 📦 Deployment

### Initialize Terraform

```bash
terraform init
```

### Review the Execution Plan

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### View Outputs

After successful deployment, Terraform will output the public IP address:

```bash
terraform output vm_public_ip
```

## 🔧 Configuration

### Variables

The following variables can be customized in `variables.tf`:

| Variable | Default Value | Description |
|----------|--------------|-------------|
| `project-name` | `terraform_demo` | Name prefix for all resources |
| `location` | `westeurope` | Azure region for deployment |
| `admin-username` | `chander` | Admin username for the VM |
| `vm-size` | `Standard_F2as_v6` | Azure VM size |
| `vm-name` | `chandervm` | Name of the virtual machine |

To override defaults, create a `terraform.tfvars` file:

```hcl
project-name   = "my-project"
location       = "northeurope"
admin-username = "yourusername"
```

## 🔐 Accessing the VM

Once deployed, connect to your VM using SSH:

```bash
ssh -i id_rsa_terraform_demo <admin-username>@<vm-public-ip>
```

Example:
```bash
ssh -i id_rsa_terraform_demo chander@<output-ip-address>
```

## 📝 Cloud-Init Configuration

The VM is initialized with `cloud-init.yaml`, which:
- Updates and upgrades system packages
- Installs `curl` and `python3-pip`
- Creates a welcome file at `/hello-from-cloud-init.txt`

Customize `cloud-init.yaml` to add your own initialization scripts.

## 🧹 Cleanup

To destroy all created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm the destruction.

**⚠️ Warning**: This will permanently delete all resources created by this Terraform configuration.

## 📂 Project Structure

```
.
├── main.tf                    # Main Terraform configuration
├── variables.tf               # Variable definitions
├── cloud-init.yaml            # VM initialization script
├── id_rsa_terraform_demo      # Private SSH key (not in git)
├── id_rsa_terraform_demo.pub  # Public SSH key
├── .terraform.lock.hcl        # Terraform dependency lock
├── terraform.tfstate          # Terraform state (not in git)
└── README.md                  # This file
```

## 🔒 Security Considerations

- **SSH Keys**: Never commit private keys to version control. Add them to `.gitignore`.
- **Terraform State**: The `terraform.tfstate` file contains sensitive information. Consider using [remote state](https://www.terraform.io/docs/language/state/remote.html) with Azure Storage for production.
- **NSG Rules**: Current configuration allows SSH from any IP (`*`). Consider restricting to specific IP ranges in production.
- **Credentials**: Avoid hardcoding credentials. Use Azure Key Vault or environment variables for sensitive data.

## 🛠️ Troubleshooting

### Common Issues

1. **VM Size Availability**: If you get a SKU not available error, check available VM sizes in your region:
   ```bash
   az vm list-skus --location westeurope --output table
   ```

2. **Authentication Errors**: Ensure you're logged in to Azure CLI:
   ```bash
   az account show
   ```

3. **Terraform State Lock**: If state is locked, you may need to force-unlock:
   ```bash
   terraform force-unlock <lock-id>
   ```

## 📚 Additional Resources

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Virtual Machine Documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/)
- [Cloud-Init Documentation](https://cloudinit.readthedocs.io/)

## 📄 License

This project is for educational and demonstration purposes.

## 👤 Author

**Chander**

---

**Note**: This is a demo project for learning Terraform and Azure infrastructure provisioning. Not intended for production use without additional security hardening and best practices implementation.
