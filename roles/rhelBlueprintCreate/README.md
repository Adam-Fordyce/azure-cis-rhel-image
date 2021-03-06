rhelBlueprintCreate
=========

Create a ImageBuilder blueprint toml file that is automatically configured using the osbuild-composer CLI interface.

Once the blueprint is created it is pushed into the osbuild service and its dependencies are resolved before the image is composed.

Requirements
------------

A minimum RHEL version of 8.4 should be used when using this role.

Role Variables
--------------

| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| image_name              | yes      |  azure-rhel-cis-master-image  | n/a    |   Name of the image that is created                         |
| image_format            | yes      | vhd        | n/a                 | Format of image (VHD for Azure)         |
| rawimage_dest           | yes      | /root/{{ image_name }}.{{ image_format }} | n/a |Location of resulting image |

Dependencies
------------

- rhelSubscriptionManagementSetup - Activates RHEL subscription
- rhelImageBuilderSetup - Configures remote VM to generate the SAP image

Example Playbook
----------------

```
- hosts: provisioner
  vars:
    image_name: "{{ site_image_name }}"
    image_format: "{{ site_image_format }}"
    rawimage_dest: "{{ host_rawimage_dest }}"
  roles:
    - rhelBlueprintCreate
```

License
-------

MIT See LICENSE

Author Information
------------------

Adam Fordyce - 2022
