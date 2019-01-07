# Lab prereqs

## Sign up for accounts

### 1. Github
Sign up for a [github account](https://github.com/join?source=experiment-header-dropdowns-home)
* request that your user be added to your company's GitHub organization

### 2. Terraform Enterprise
Sign up for a [terraform enterprise account](https://app.terraform.io/account/new)
* request that your user be added to your companies TFE organization

### 3. Cloud Acount (AWS or Azure)
* Create an AWS free account at https://aws.amazon.com/free/
* Create an Azure free account at https://azure.microsoft.com/en-us/free/
* or contact company cloud admin 

## Install software

### 1. Terrafrom 
Download appropriate terraform package [here](https://www.terraform.io/downloads.html)
* Linux/macs- unzip terraform binary and copy to a $PATH dir (/usr/local/bin/terraform)
* Windows- unzip terraform.exe and copy to a %PATH% dir (c:\Windows\System32\terraform.exe)

### 2. Git
* Windows - [Install Git for Windows](https://gitforwindows.org/)
* Mac - [Install Git for Mac](https://gist.github.com/derhuerst/1b15ff4652a867391f03#file-mac-md)
* Linux - [Install Git for Linux](https://gist.github.com/derhuerst/1b15ff4652a867391f03#file-linux-md)

### 3. An IDE that supports terraform syntax
(optional) Suggest installing an IDE that supports terraform
* [Atom download](https://atom.io/) and
  [Atom Terraform plugin](https://atom.io/packages/language-terraform)
* [Visual Studio Code](https://code.visualstudio.com/Download) and 
  [VSC Terraform plugin](https://marketplace.visualstudio.com/items?itemName=mauve.terraform)
* [PyCharm download](https://www.jetbrains.com/pycharm/download/#section=linux) and
  [PyCharm Terraform plugin](https://plugins.jetbrains.com/plugin/7808-hashicorp-terraform--hcl-language-support)
  
### 4. Cloud CLI (aws or az)
To get API credentials for your AWS or Azure cloud account
* For an AWS API credentials for an IAM user (not SAML SSO), see the 
  [this documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey)
* To get AWS API credentials when using SAML SSO, you'll need to install can configure the tool: 
  [saml2aws](https://github.com/Versent/saml2aws)
* To Azure get credentials, you'll need to install the Azure CLI
  [instructions here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest)
            
**Windows users**: you might like software package management tool called choco (https://chocolatey.org/) which 
        allows you to download and install all lab requirements with one powershell command!
        `choco install -y terraform git atom awscli azure-cli sam2aws`
