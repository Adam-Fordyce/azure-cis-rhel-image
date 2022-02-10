azureUploadImage
=========

Creates an Azure storage blob and uploads a custom VM Image into it for use within the Azure environment.

Requirements
------------

 - The inventory must be updated with the correct market place image details
 - The vault must be present and populated with valid credentials

Role Variables
--------------

| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| resource_group          | yes      |         | n/a                       | Name of Azure resource group             |
| security_group          | yes      |         | n/a                       | Name of Azure security group             |
| security_group_rules    | yes      | 22, 9090| n/a                       | Azure security group rules (list)        |
| virtual_network         | yes      |         | n/a                       | Name of Azure virtual network            |
| virtual_network_subnet  | yes      |         | n/a                       | Name of Azure virtual networks subnet    |
| azure_region            | yes      |         | n/a                       | Region in Azure where resources are      |

Dependencies
------------

- azureVpc: This role will create the Azure VPC
- azureVm: This role will create the Azure VM
- rhelSubscriptionManagementSetup - Sets up the RHEL subscription on the VM
- rhelImageBuilderSetup - Prepares the OS to use ImageBuilder with a SAP subscription
- rhelBlueprintCreate - Creates a SAP HANA RHEL image
- rhelImageCustomisation - Customises the new image before it is uploaded to Azure

Example Playbook
----------------

```
- name: "Upload Image to Azure"
  include_role:
    name: azureUploadImage

```

License
-------

MIT - See LICENSE

Author Information
------------------

Adam Fordyce - 2022
