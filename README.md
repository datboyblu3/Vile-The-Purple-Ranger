# TheVileCounter

![vil32](https://github.com/datboyblu3/TheA02Counter/assets/95729902/365eb105-fc8c-44f9-b91d-f531eaea60f3)

Using Terraform and Ansible to build and configure the overall infrastructure, this repo will be a cyber range for red teams to carry out attacks and for blue teams to counter with detections and mitigations. Thus engaging in a full on purple team effort. Build your skills to frustrate and break the spirits of your adversaries, making any attack on your infrastructure a truly *Vile* endeavor for all who dare to challenge you.

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


