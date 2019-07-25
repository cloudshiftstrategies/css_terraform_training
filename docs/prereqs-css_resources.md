# Lab prerequisites

## Test access to the following services

### 1. Github
- url: [https://github.com](https://github.com)
- user: csslabsuser
- password: xxx
- organization: cloudshiftlabs

### 2. Terraform Enterprise
- url: [https://app.terraform.io/session](https://app.terraform.io/session)
- user: csslabsuser
- password: xxx
- organization: cloudshiftstrategies
- TFE_TOKEN: xxx

### 3. Cloud Account AWS
- url: [https://css-lab2.signin.aws.amazon.com/console](https://css-lab2.signin.aws.amazon.com/console)
- user: csslabsuser
- password: xxx
- AWS_ACCESS_KEY_ID: xxx
- AWS_SECRET_ACCESS_KEY: xxx

## Install software

### 1. Terraform 
Download appropriate terraform binary [here](https://www.terraform.io/downloads.html)
* Linux/macs- unzip terraform binary and copy to a $PATH dir (/usr/local/bin/terraform)
* Windows- unzip terraform.exe and copy to a %PATH% dir (c:\Windows\System32\terraform.exe)

### 2. Git
* Windows - [Install Git for Windows](https://gitforwindows.org/)
* Mac - [Install Git for Mac](https://gist.github.com/derhuerst/1b15ff4652a867391f03#file-mac-md)
* Linux - [Install Git for Linux](https://gist.github.com/derhuerst/1b15ff4652a867391f03#file-linux-md)

### 3. An IDE that supports terraform syntax highlighting
(optional) Suggest installing an IDE that supports terraform
* [Atom download](https://atom.io/) and
  [Atom Terraform plugin](https://atom.io/packages/language-terraform)
* [Visual Studio Code](https://code.visualstudio.com/Download) and 
  [VSC Terraform plugin](https://marketplace.visualstudio.com/items?itemName=mauve.terraform)
* [PyCharm download](https://www.jetbrains.com/pycharm/download/#section=linux) and
  [PyCharm Terraform plugin](https://plugins.jetbrains.com/plugin/7808-hashicorp-terraform--hcl-language-support)
  
### 4. AWS CLI 
* Windows - [Install AWS CLI on Windows](https://docs.aws.amazon.com/cli/latest/userguide/install-windows.html)
* Linux - [Install AWS CLI on Linux](https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html)
* Mac - [Install AWS CLI on macOS](https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html)
            
**Windows users**: you might like software package management tool called choco (https://chocolatey.org/) which 
        allows you to download and install all lab requirements with one powershell command!
        `choco install -y terraform git atom awscli azure-cli saml2aws jq`