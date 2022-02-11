#!/usr/bin/bash
# Download the required yml files and files
git clone https://github.com/EdwardJ1n/sap-hana-hsr-with-ha-on-azure-example.git  saphana_deployment >> /root/first_run.sh.log

# Install the required packages for the Azure Python SDK modules.
pip3 install --upgrade pip >> /root/first_run.sh.log
pip install 'ansible[azure]' --use-feature=2020-resolver >> /root/first_run.sh.log

# Download Ansible roles for SAP HANA deployments
ansible-galaxy install -r /root/saphana_deployment/roles/requirements.yml >> /root/first_run.sh.log
