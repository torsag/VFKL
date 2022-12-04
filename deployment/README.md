# Deploy VFKL
Currently, the functiona app is deployed via powershell script. The powershell script can be found under deployment. We have 2 deployment scripts available as the naming conventions were changed. 
- provision_VFKLCore.ps1 - Deploy to development environment
- provision_VFKLCoreProd.ps1 - Deploy to production environment

The other environments have to be updated with the same naming convention in the future.

## Provision Infrastructure and Deploy
The script provisions the infrastructure and deploys the function app to Azure. When run first, the necessary infrastructure will be created in Azure and the lateral runs will just update the app and any infrastructure changes. The infrastructure provisioning and function deploy can be split into 2 different scripts for better performance. This will be done in the next phase.

The script has necessary comments for understanding.

### Prerequisites
- You must have an azure subscription.
- AZ CLI. You can find the installation guide [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
- azure-functions-core-tools can be installed from (https://www.npmjs.com/package/azure-functions-core-tools). Remember to install V4.

### Run the script
- Navigate to deployment folder in command line
- Login to azure using **az login** command
- Run the script f.example type **provision_VFKLCore.ps1** with  necessary inputs and press enter
- The script will print the resource details as and when it is created.

### Verify in Azure
Once the script is run successfully, login to azure and verify the necessary resources are created. You can go to your subscription and click on resources to verify that all the resources are available.
