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
| azure_subscription_id   | yes      |         | n/a                       | Azure subscription ID                    |
| azure_client_id         | yes      |         | n/a                       | Service Principal Client ID              |
| azure_secret            | yes      |         | n/a                       | Service Principal Secret                 |
| azure_tenant            | yes      |         | n/a                       | Azure tenant ID                          |
| resource_group          | yes      |         | n/a                       | Name of Azure resource group             |
| storage_account         | yes      |         | n/a                       | Name of Azure storage account            |
| storage_container       | yes      |         | n/a                       | Name of Azure storage container            |
| image_name              | yes      |         | n/a                       | Name of custom Azure image            |
| image_URI              | yes      |         | n/a                       | URI on Azure of Image            |
| image_format              | yes      |  vhd    | n/a                       | Format of image file          |
| image_src              | yes      |         | n/a                       | Local path to custom image file       |

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
  vars:
    azure_subscription_id: "{{ vault_azure_subscription_id }}"
    azure_client_id: "{{ vault_azure_client_id }}"
    azure_secret: "{{ vault_azure_secret }}"
    azure_tenant: "{{ vault_azure_tenant }}"
    resource_group: "{{ site_resource_group }}"
    storage_account: "{{ site_storage_account }}"
    storage_container: "{{ site_storage_container }}"
    image_name: "{{ site_image_name }}"
    image_URI: "{{ host_image_URI }}"
    image_format: "{{ site_image_format }}"
    image_src: "{{ host_rawimage_dest }}"

```

License
-------

MIT - See LICENSE

Author Information
------------------

Adam Fordyce - 2022
