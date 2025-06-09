# TripAdvisor Foundry Agents Demo

## Overview

TripAdvisor Foundry (Demo) is a sample project designed to demonstrate how Azure services can be used to build a scalable, cloud-based solution for processing and analyzing travel data. This demo simulates a real-world scenario using TripAdvisor data and showcases how Azure AI Foundry Agents can be integrated into a modern data pipeline. It's intended as a learning and exploration tool for developers and architects interested in AI-driven cloud solutions.

## Architecture

The solution implements a microservices architecture pattern with the following Azure components:

### Core Services
- **Azure Foundry Components**: Including Azure Foundry Agents service and Azure OpenAI
- **Bing Services**: Delivers search and mapping capabilities for location-based features
- **Azure Logic Apps**: Orchestrates automated workflows and integrations for data processing
- **Azure Communication Services**: Manages email communication workflows with custom domain support
- **Azure Key Vault**: Securely stores secrets, certificates, and configuration data
- **Azure Storage Account**: Provides scalable storage for data assets and application artifacts

## Prerequisites

Before getting started, ensure you have the following tools and accounts:

### Required Tools
- [Azure Account](https://azure.microsoft.com/en-us/free/) with Contributor permissions
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) v2.50.0 or newer
- [Terraform](https://www.terraform.io/downloads.html) v1.5.0 or newer
- [Git](https://git-scm.com/downloads) for repository management

### Azure Permissions
Your Azure account must have:
- Contributor access to the target subscription
- Ability to create service principals and users
- Permission to register Azure AD applications

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/omerfeldman22/TripAdvisorFoundry.git
cd TripAdvisorFoundry
```

### 2. Azure Authentication

Authenticate with Azure using the CLI:

```bash
# Login to Azure
az login
```

### 3. Configure Terraform Variables

Navigate to the Infrastructure as Code directory:

```bash
cd IaC
```

Create your Terraform variables (```terraform.tfvars```) file with the following content:

```terraform.tfvars
subscription_id = "<YOUR_SUBSCRIPTION_ID>"
base_name           = "<PREFIX_NAME_FOR_THE_CREATED_RESOURCE>" // only alpha-numeric characters allowed, no more than 8 characters
location            = "<AZURE_REGION>" // For example "Sweden Central"
data_location = "<DATA_RESIDENCY_LOCATION>" // For example "Europe"
environments_amount = <INT>
password = <PASSWORD_FOR_THE_CREATED_USERS>
```

### 4. Initialize Terraform

Initialize and run the Terraform working directory:

```bash
terraform init
terraform apply -auto-approve
```

## 5. Manual Actions
* If there is Any conditional Access that is preventing users to sign in, Please Exclude the group named ```foundry-agents-demo-group``` from any policy
* For Each environment perform the followings:
   * Add MFA for each environment user if needed
   * Create an Foundry Agent Service Project
   * Go to the Management Center and then to Connected Resources and Create a new connection for the Trip Advisor API:
      * Click on 'New Connection'
      * Choose Custom Keys
      * Click on 'Add key value pairs' -> enter the 'key' to the key and the API_KEY_VALUE for the value, and check the 'is secret' checkbox
      * For the connection name choose 'TripAdvisorAPIKey'
      * For Access choose the 'Shared to all projects'

## 6. Validate functionality

Start creating the AI Agents in the Foundry Agent Service.


## 7. Cleanup
To remove all created resources:

```bash
terraform destroy -auto-approve
```

**Warning**: This will permanently delete all resources. Ensure you have backed up any important data.

### 8. Contact

For any questions or feedback, please open an issue or contact the maintainers:

Omer Feldman - omerfeldman@microsoft.com
