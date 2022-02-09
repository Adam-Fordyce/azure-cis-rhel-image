rhelImageBuilderSetup
=========

Sets the subscription manager release on a RHEL system and enables the repositories for SAP Solutions, Ansible, and Microsoft Azure CLI. With the appropriate subscriptions and repositories in place the osbuild-composer and cockpit services are enabled and started. The osbuild-composer service is configured to use the correct repository sources which are not inherited from the base OS.


Requirements
------------

The OS must have a valid active RedHat subscription.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| ansible_user            | yes       | root | Inherited from setup module during gather facts              | example variable                         |

Dependencies
------------

- rhelSubscriptionManagementSetup: This role will activate the RHEL subscription.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: provisioner
      roles:
         - rhelImageBuilderSetup

License
-------

MIT - See LICENSE

Author Information
------------------

Adam Fordyce - 2022
