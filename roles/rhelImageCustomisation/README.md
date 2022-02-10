rhelImageCustomation
=========

Customise an ImageBuilder generated image file. Adds:
  - Firstboot script - to prepare image for SAP HANA deployments
  - Inject root SSH key file
  - Set root user password
  - Set initial hostname

Requirements
------------

The OS must have a valid active RedHat subscription.
An ImageBuilder generated image for SAP Solutions

Role Variables
--------------


| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| ansible_user            | yes      | root    | Inherited from setup module| User name that will run osimage-composer |
| image_dest              | yes      |         |                           | Location of output image    |
| ssh_private_key_name    | yes      |         |                           | Value taken from vault      |
| ssh_private_key_data    | yes      |         |                           | Value taken from vault      |

Dependencies
------------

- RHEL8.4 Base OS
- rhelSubscriptionManagementSetup: This role will activate the RHEL subscription.
- rhelImageBuilderSetup: This role will prepare the ImageBuilder application
- rhelBlueprintCreate: Generates an initial image

Example Playbook
----------------

```
    - name: Customise the cloud image
      include_role:
        name: rhelImageCustomisation
      vars:
        image_name: "{{ site_image_name }}"
        image_format: "{{ site_image_format }}"
        image_dest: "{{ host_image_dest }}"
        ssh_private_key_name: "{{ vault_ssh_public_key_name }}"
        ssh_private_key_data: "{{ vault_ssh_public_key_data }}"- name: Prepare osbuild-composer to generate a SAP image

```

License
-------

MIT - See LICENSE

Author Information
------------------

Adam Fordyce - 2022
