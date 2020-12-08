# Cloud Entitlements Manager SE Provisioning Tool

Quick tool to make it easier to provision/deprovision the Ansible playbooks from [@QuincyCheng](https://github.com/quincycheng/cem-demo-ansible).  Keys are pulled from the CyberArk Vault using CP

**TO-DO's**
1. Unset export Variables when playbook is complete.
2. Look into passing the aws keys via the option extra_vars=
3. Ditch the bash script and pull the keys directly into the playbook.

## How to Use
1. Update line 12 with the path to the Quincy's Ansible playbooks. 
2. Update line 15 with the proper values to pull the creds in from the correct safe.
