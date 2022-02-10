azureVpc
=========

Creates a VPC within Azure. This comprises of a resource group with virtual network, virtual subnet, and security group.

Requirements
------------

Azure Account with valid credentials

Role Variables
--------------

| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| state                   | yes      | n/a     | present, absent           | An action variable to dictate the state of the Azure VPC                |
| resource_group          | yes      |         |                           | Name of Azure resource group             |
| azure_region            | yes      |         |                           | Region where Azure resources are located |
| virtual_network_subnet  | yes      |         |                           | Name of virtual network subnet           |
| subnet_cidr             | yes      |         |                           | CIDR value for subnet                    |
| virtual_network         | yes      |         |                           | Name of virtual network                  |
| supernet_cidr           | yes      |         |                           | CIDR value for supernet                  |

Dependencies
------------
none

Example Playbook
----------------

```
- name: "Create the Azure VPC"
  include_role:
    name: azureVpc
  vars:
    state: present
    resource_group: "{{ site_resource_group }}"
    azure_region: "{{ site_azure_region }}"
    virtual_network_subnet: "{{ site_virtual_network_subnet }}"
    subnet_cidr: "{{ site_subnet_cidr }}"
    supernet_cidr: "{{ site_supernet_cidr }}"
    virtual_network: "{{ site_virtual_network }}"
```

License
-------

MIT See LICENSE

Author Information
------------------

Adam Fordyce
