# Vile: The Purple Ranger

![vil32](https://github.com/datboyblu3/TheA02Counter/assets/95729902/365eb105-fc8c-44f9-b91d-f531eaea60f3)

Using Terraform and Ansible to build and configure the overall infrastructure, this repo will be a cyber range for red teams to carry out attacks and for blue teams to counter with detections and mitigations, engaging in a full scope purple team effort. Build your skills to frustrate and break the spirits of your adversaries, making any offense on your infrastructure a truly *Vile* endeavor for all who dare to cross your threshold.

# Table of Contents

- [Project Mock Up](#project-mock-up)
  
  - [Wazuh Deployment](#wazuh-deployment)
  
  - [Lab Topology](#lab-topology)
- [Semantic Versioning](#semantic-versioning)
- [Common Configuration Errors](#common-configuration-errors)
- [Install the Terraform CLI](#install-the-terraform-cli)
- [Terraform Basics](#terraform-basics)
- [Troubleshooting](#troubleshooting)


## Project Mock Up

### Wazuh Deployment

![](https://github.com/datboyblu3/Vile-The-Purple-Ranger/blob/main/attachements/wazuh-deployment.gif)

### Lab Topology

![](https://github.com/datboyblu3/Vile-The-Purple-Ranger/blob/main/attachements/lab_topology.gif)

## Semantic Versioning

This project is going to utilize the semantic versioning for its tagging.

[semver.org](https://semver.org/)

The general format: 

**MAJOR.MINOR.PATCH**, eg `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.


## Common Configuration Errors

### Problem 1: "Wazuh dashboard is not ready yet"

**Execute the below command on the Wazuh Indexer**
```python3
cat /var/log/wazuh-indexer/wazuh-cluster.log | grep -i -E "error|warn"
```

![indexer-error-warn](https://github.com/datboyblu3/Vile-The-Purple-Ranger/assets/95729902/1d2cff2b-554a-4d49-94db-9b42000c0d66)

**Execute command on the Wazuh Dashboard**
```python3
cat /usr/share/wazuh-dashboard/data/wazuh/logs/wazuhapp.log | grep -i -E "error|warn"
```
![dashboard-error](https://github.com/datboyblu3/Vile-The-Purple-Ranger/assets/95729902/7925e325-0b31-4e3d-9c4e-8efcccd236bd)


The first error indicates an authentication issue with the kibanaserver user. The second shows there is a connection error on the dashboard.

### Solution
Consult the [following password management documentation](https://documentation.wazuh.com/current/user-manual/user-administration/password-management.html#changing-the-passwords-in-a-distributed-environment) to fix the issue. Follow step 3 of "Changing the passwords in a distributed environment"



## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install the Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu. Please consider verifying your Linux Distribution and change according to your distribution needs

[How to Check OS Version in Linux](
https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/
)

Example of checking OS version:
```bash
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io)

- **Providers** is an interface to APIs that will allow to create resources in terraform
- **Modules** are a way to make large amount of terraform code modular, portable and sharable

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)
### Terraform Console

We can see a list of all Terraform commands by simply typing `terraform`

#### Terraform init

At the start of a new Terraform project we will run `terraform init` to download the binaries for the terraform providers
that we'll use in this project

#### Terraform Plan

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.

Apply the `--auto-approve` flag to automatically approve a terraform transaction

#### Terraform Destroy

This will destroy resources. This can use the `--auto-approve` flag as well
```
terraform destroy --auto-approve
```

If you receive an Access Denied message when deleting, verify your permissions, groups and ensure you have the proper group name.

Troubleshooting tips:
- https://saturncloud.io/blog/troubleshooting-s3-error-access-denied-when-calling-the-listbuckets-operation/

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used
with this project.

The Terraform Lock File should be committed to your Version Control System - i.e GitHub

### Terraform State File

`.terraform.tfstate` contain information about the current state of your infrastructure .

This file **should not be committed** to your VCS. This file can contain sensitive information.
If you lose this file, you will lose the knowledge of your infrastructure. 

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers

## Troubleshooting

**Tailscale command not recognized on Macbook M2**
Create a temp alias for tailscale
```
alias tailscale /Applications/Tailscale.app/Contents/MacOS/Tailscale
```


