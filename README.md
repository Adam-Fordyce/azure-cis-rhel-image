# azure-cis-rhel-image
Create a hardened CIS image in azure using Ansible
## Overview

This prject will facilitate a custom RHEL image in Azure using the RedHat Image Builder application.

The following diagram reflects the various stages of deployment that are employed by the ansible code.

![Diagram of Ansible workflow](docs/CIS%20Hardened%20Image.drawio.png)
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

    1. Open Windows PowerShell as an administrator and run the following:
        ```
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
        ```
    1. Restart your PC and re-open an admin PowerShell
    1. Enable VirtualMachinePlatform and WindowsSubsystemForLinux
        ```
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        ```
    1. Restart your PC
    1. Download and install the latest Linux kernel
        > [Linux kernel update package](https://aka.ms/wsl2kernel)

1. Set WSL2 as the default
    1. Open another Windows PowerShell with administrator privileges
        ```
        wsl --set-default-version 2
        ```

1. Install a Linux flavour
    1. Open the Microsoft store and select a distribution
        > Suggest: Ubuntu 20.04 LTS

    1. The first time a newly installed Linux distribution gets launched, a console window will load up and display the installation progress.
        1. Enter a new user name for the Linux distribution
        1. Enter the password for the new user
            > this will also be the sudo password.

1. Create `/etc/wsl.conf`

   1. Open WSL2 Distro
   1. In the terminal window, create the file `/etc/wsl.conf`
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
   1. Restart WSL from windows command prompt / power shell window
        ```
        wsl --shutdown
        ```
        > Re-open the WSL distribution once it has restarted; the environment can now correctly set Linux permissions on files on the Windows filesystem.
1. Install Windows Terminal

### Prepare the WSL Linux distribution
1. Install Ansible
    ```
    sudo apt install ansible OpenSSH git
    [ENTER ROOT PASSWORD]
    ```

### Authentication Setup
1. Checkout the latest version of this project
    1. In the Linux environment change to a location accessible by Windows and Linux
        ```
        cd /mnt/c/Users/{{ username }}/Documents/
        ```
    1. Clone the latest version of this repo
        ```
        git clone https://github.com/Adam-Fordyce/azure-cis-rhel-image.git
        ```

1. Create an Azure credentials file
    1. Create the file path
        ```
        mkdir -p ~/.azure/
        touch ~/.azure/credentials
        ```
    1. Add the following contents to the file
        ```
        [default]
        subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        secret=xxxxxxxxxxxxxxxxx
        tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        ```
        > Insert the relevant details from the information for the Service Principle account.

1. Configure SSH
    1. Generate using the following command
        ```
        ssh-keygen
        ```
    1. Copy `~/.ssh/id_rsa` to the project folder
    1. Set the permissions of the copied file
        ```
        chmod 600 id_rsa
        ```
    1. Edit `inventory/group_vars/all/main.yml` and update the `ssh_key_data` variable
    1. Get the data for the ssh_key_data variable
        ```
        cat ~/.ssh/id_rsa.pub
        ```
    1. Copy this information and paste it into the `inventory/group_vars/all/main.yml`
    1. Save and close the file

## Deployment

1. The Ansible inventory has two hosts defined initially
    1. localhost - The local machine in the controller group
    1. provisioner - The remote RHEL machine used to stage the images, this is in the cloud group

        ```
        ansible-inventory -i inventory --graph

        @all:
        |--@cloud:
        |  |--provisioner
        |--@ungrouped:
        ```

1. Run the following command from the root folder in the cloned repository

    ```
    ansible-playbook -i inventory deploy_azure.yml
    # Wait...
    ```

    > This will result in a RHEL8 VM being started in Azure

    > Access the WebUI using: `{{ public IP address }}:9090` use the inventory user details for access.

1. To stop the VM and destroy the Azure resources enter the following command:

    ```
    ansible-playbook -i inventory plays/destroy_azure.yml
    # Wait...
    ```

## Author

Adam Fordyce
