azureVm
=========

Creates/Destroys a VM with a managed storage volume in Azure using the details from the inventory for the image.

Requirements
------------

 - The inventory must be updated with the correct market place image details
 - The vault must be present and populated with valid credentials

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| state                   | yes      |         | present, absent           | Invocation action                        |
| resource_group          | yes      |         | n/a                       | Name of Azure resource group             |
| public_ip               | yes      |         | n/a                       | Name of Azure public IP resource         |
| security_group          | yes      |         | n/a                       | Name of Azure security group             |
| security_group_rules    | yes      | 22, 9090| n/a                       | Azure security group rules (list)        |
| nic                     | yes      |         | n/a                       | Name of Azure network interface          |
| flavor                  | yes      | Standard_D2as_v4  | n/a                       | Type of Azure instance to start the image on |
| vmname                  | yes      |         | n/a                       | Name of Azure VM                         |
| azure_image             | yes      |         | n/a                       | Name of Azure image e.g. golden-image    |
| virtual_network         | yes      |         | n/a                       | Name of Azure virtual network            |
| virtual_network_subnet  | yes      |         | n/a                       | Name of Azure virtual networks subnet    |
| azure_region            | yes      |         | n/a                       | Region in Azure where resources are      |
| admin_user              | yes      |         | n/a                       | OS administrative user                   |
| admin_pass              | yes      |         | n/a                       | OS administrative users password         |
| ssh_public_key_data     | yes      |         | n/a                       | SSH Public key data                      |

Dependencies
------------

- azureVpc: This role will create the Azure VPC

Example Playbook
----------------

```
- name: "Create Provisioner VM"
  include_role:
    name: azureVm
  vars:
    state: present
    resource_group: "{{ site_resource_group }}"
    public_ip: "{{ hostvars[vm].public_ip }}"
    security_group: "{{ hostvars[vm].security_group }}"
    security_group_rules: "{{ hostvars[vm].security_group_rules }}"
    nic: "{{ hostvars[vm].nic }}"
    flavor: "{{ hostvars[vm].flavor }}"
    vmname: "{{ hostvars[vm].inventory_hostname }}"
    azure_image: "{{ hostvars[vm].azure_image }}"
    virtual_network: "{{ site_virtual_network }}"
    virtual_network_subnet: "{{ site_virtual_network_subnet }}"
    azure_region: "{{ site_azure_region }}"
    admin_user: "{{ vault_admin_user }}"
    admin_pass: "{{ vault_admin_pass }}"
    ssh_key_public_data: "{{ vault_ssh_key_public_data }}"
    loop: "{{ groups['cloud'] }}"
    loop_control:
    loop_var: vm
    label: "Creating cloud VM {{ hostvars[vm].inventory_hostname }}"
```

License
-------

MIT - See LICENSE

Author Information
------------------

Adam Fordyce - 2022
