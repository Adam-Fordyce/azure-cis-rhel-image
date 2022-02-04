# azure-cis-rhel-image
Create a hardend CIS image in azure using Ansible

## Setup

### Azure Setup
1. Register an application with the Microsoft Identity Platform

    > [Microsoft Quickstart: Application Registration](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app)

    > [Microsoft Tutorial: Create an Azure Service Principle](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?WT.mc_id=devto-blog-jedavis&view=azure-cli-latest)

1. Take note of the following parameters
    ```
    [default]
    subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    secret=xxxxxxxxxxxxxxxxx
    tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ```

### Local Setup

1. Activate WSL
    ```

    ```
1. Set WSL2 as default

1. Install a linux flavor
    > Set a root password
1. Create `/etc/wsl.conf`

   1. Open WSL2 Distro
   1. In the terminal window create the file `/etc/wsl.conf`
        ```
        sudo su -
        [ENTER ROOT PASSWORD]
        touch /etc/wsl.conf
        ```
   1. Edit `/etc/wsl.conf` and add the following parameters
        ```
        [automount]
        enabled = true
        options = "metadata,uid=1000,gid=1000,umask=0022,fmask=11,case=off"
        mountFsTab = false
        crossDistro = true

        [filesystem]
        umask = 0022

        [network]
        generateHosts = true
        generateResolvConf = true

        [interop]
        enabled = true
        appendWindowsPath = true
        ```
   1. Save and exit the file
   1. Restart WSL from a windows command prompt / power shell window
        ```
        wsl --shutdown
        ```
        > Re-open the WSL distrobution once it has been restarted, the environment now has the ability to correctly set linux permissions on files that are on the Windows filesystem. This is required for things like ssh keys.
1. Install Windows Terminal


## Deployment

1. Checkout the latest version of this project

1. Create an Azure credentials file
