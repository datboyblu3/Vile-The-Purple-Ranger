# TheVileCounter

![vil32](https://github.com/datboyblu3/TheA02Counter/assets/95729902/365eb105-fc8c-44f9-b91d-f531eaea60f3)

Using Terraform and Ansible to build and configure the overall infrastructure, this repo will be a cyber range for red teams to carry out attacks and for blue teams to counter with detections and mitigations. Thus engaging in a full on purple team effort. Build your skills to frustrate and break the spirits of your adversaries, making any attack on your infrastructure a truly *Vile* endeavor for all who dare to challenge you.

This project will be built on top of proxmox as the 

## Semantic Versioning :mage:

This project is going to utilize the semantic versioning for its tagging.

[semver.org](https://semver.org/)

The general format: 

**MAJOR.MINOR.PATCH**, eg `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

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
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/troubleshoot-403-errors.html

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


