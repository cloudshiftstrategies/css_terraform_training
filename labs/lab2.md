# TFE Lab

In this lab, we'll practice using Terraform Enterprise and Github

Before you start the lab, make sure that you have met the requirements defined
in [lab prereqs](../docs/prereqs.md) document.

##1. Configure Github repo

####1.1 Validate github login

Go to https://github.com confirm that you can login. 

Try accessing your company's github organization https://github.com/GH_ORG_NAME

####1.2 Create a new github repo

Create a new private repository named `tfe_lab_ABC` where ABC are your initials **in your company organization**
![gh repo](images/gh_repo1.png)

 * check Initialize this repository with a README
 * select the Terraform .gitignore template

##2. Configure TFE workspace

####2.1  Validate TFE login

Go to https://app.terraform.io/app and confirm that you can login and see your organization

####2.2 Create a terraform workspace and link to repo

Create a new workspace named `tfe_lab_ABC` where ABC are your initials

![new_tfe_workspace](images/tfe_new_workspace.png)

####2.3 Configure variables to set cloud provider credentials

Workspace > tfe_lab_ABC > Variables > Environment Variables

Set the cloud provider credentials:

Azure requires:
* ARM_SUBSCRIPTION_ID
* ARM_CLIENT_ID
* ARM_TENANET_ID
* ARM_CLIENT_SECRET (sensitive)

Example Azure credentials set:
![az_vars](../docs/images/tfe_az_keys.png)

####4. Install TFE API key

TODO: determine if we need to do this

##3. work on project

####3.1 Login to Azure portal

https://portal.azure.com/ 
and go to a **non production** subscription

Open terminal
![azure term](images/azure_term.png)

####3.2 Clone the new github repo you created

Copy the repo http url from Github.com
![gh clone link](images/gh_clone_link.png)

Execute the following command in the Azure terminal, replacing YOUR_ORG and ABC
```bash
git clone https://github.com/YOUR_ORG/tfe_lab_ABC.git
cd tfe_lab_*
```

####3.3 Upload a terraform file

Download the maint.tf sample file

to your PC then upload to azure terminal

## trigger a plan with VCS change

## view plan

## apply run

## create a branch

## test locally, see speculative plan

## create pull request to merge, see speculative plan

# 1 person... 
# Create a github repo for module (fork?)

# create a private module in tfe

# branch - reference private module from workspace code

# pull request - check speculative plan

# apply

# 1 person
# create centenal policy