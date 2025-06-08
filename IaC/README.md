# Azure AI Terraform Project

This project contains Terraform configurations for deploying Azure AI Foundry, Azure OpenAI, and Azure Bing Search services.

## Project Structure

```
azure-ai-terraform
├── main.tf                # Main configuration file for Terraform
├── variables.tf           # Input variables for customization
├── outputs.tf             # Output values after deployment
├── provider.tf            # Provider configuration for Azure
├── modules
│   ├── ai-foundry         # Module for Azure AI Foundry
│   │   ├── main.tf        # AI Foundry specific resources
│   │   ├── variables.tf   # Variables for AI Foundry module
│   │   └── outputs.tf     # Outputs for AI Foundry module
│   ├── openai             # Module for Azure OpenAI
│   │   ├── main.tf        # OpenAI specific resources
│   │   ├── variables.tf   # Variables for OpenAI module
│   │   └── outputs.tf     # Outputs for OpenAI module
│   └── bing-search        # Module for Azure Bing Search
│       ├── main.tf        # Bing Search specific resources
│       ├── variables.tf   # Variables for Bing Search module
│       └── outputs.tf     # Outputs for Bing Search module
├── terraform.tfvars.example # Example variable values
└── README.md              # Project documentation
```

## Setup Instructions

1. **Prerequisites**: Ensure you have Terraform installed and configured on your machine. You will also need an Azure account with the necessary permissions to create resources.

2. **Clone the Repository**: Clone this repository to your local machine.

   ```bash
   git clone <repository-url>
   cd azure-ai-terraform
   ```

3. **Configure Variables**: Update the `terraform.tfvars` file with your desired configuration values. You can refer to `terraform.tfvars.example` for guidance.

4. **Initialize Terraform**: Run the following command to initialize the Terraform configuration.

   ```bash
   terraform init
   ```

5. **Plan the Deployment**: Execute the plan command to see the resources that will be created.

   ```bash
   terraform plan
   ```

6. **Apply the Configuration**: Deploy the resources by running:

   ```bash
   terraform apply
   ```

7. **Outputs**: After the deployment is complete, Terraform will display the output values defined in `outputs.tf`.

## Usage

This project is designed to simplify the deployment of Azure AI services. You can customize the deployment by modifying the variables in `variables.tf` and the respective module variable files. Each module is self-contained and can be used independently or together as needed.

For further details on each service, refer to the official Azure documentation.