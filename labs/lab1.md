# Lab 1

1. Using powershell or terminal app, run `terraform --version` to determine the version of terraform installed

        terraform --version
        
        Terraform v0.11.11
        
2. Create a new project folder in your home directory 

        cd $HOME
        mkdir terrafrom_lab1
        
     Note, you can make this directory with whatever name in wherever location you like

3. Start the IDE you installed (instructions will be provided for Atom) and install the terraform plugin

    * Open the Atom IDE (you can close all the open windows/tabs) 
    * Go to File > Settings > +Install
    * Search for "terraform" > Install the **"language-terraform"** package
    
    * Search for "ide-terminal" > Install the **"platformio-ide-terminal"** package

    ![atom-terraform](images/Atom_tfe_module.PNG)

4. Open the terraform_lab1 project folder in Atom

    * File > Open Folder
    * Select terraform_lab1 directory and click open

5. Create a new terraform file in the project folder using atom

    * Right click terraform_lab1 project directory > New File
    * Create a new file called main.tf 
    
6. Create a single output in main.tf 
    
    * Set the output name name: "first_output" with a value of "hello world"
    
    ```hcl-terraform
    # main.tf
    output "first_output" {
      value = "hello world"
    }
    ```
    
    * Be sure to save main.tf `CTRL-S` or File > Save
    * Select Platform > platformio-ide-terminal > toggle to open a terminal in the ide
    * Run `terraform apply` to see the output
    
    Your output should look like this
    
        ```
        $ terraform apply

        Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

        Outputs:

        first_output = hello world

       ```
    
7. Add a variable to main.tf 
 
    * Set the variable name to "my_name" with no default value
    * Set the value of the output: "first_output" to be the value of "my_name"
    
    ```hcl-terraform
    # main.tf
    variable "my_name" {
    }

    output "first_output" {
      value = "${var.my_name}"
    }
    ```
    
    * Run `terraform apply -var my_name="YOUR_NAME"` to set the value of the variable to your name
    
    your output should look like this
    
        ```
        $ terraform apply -var my_name="Brian Peterson"
        Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

        Outputs:

        first_output = Brian Peterson
        ```
        
8. Login to AWS using ADFS with the saml2aws utility
 
    * run `saml2aws configure` with the following parameters
    
        * Provider: ADFS
        * URL: YOUR_ADFS_LOGIN_URL < ex. https://adfs.company.com/adfs/ls/IdpInitiatedSignOn.aspx
        * Username: AD_USER_EMAIL < ex. joe.user@company.com
        * MFA: Auto
        * Profile: default < can use anything, but default is easiest
        
    * run `saml2aws login` and login using your AD username/password
    
        * Username: AD_USER_EMAIL
        * Password: AD_PASSWORD
        * Please choose role: Select an *administrative* role in a *NON PROD* account
        
    * run `aws ec2 describe-instances --region us-east-2`
    
9. Add a cloud provider and aws_instance to your main.tf
    
    * Define the provider as "aws", region "us-east-2", do not specify credentials as many examples show
    * Define an aws ec2 vm instance of type: t2_micro and ami: ami-050553a7784d00d21" with a tag:Name = var.my_name
    * Define a single output called instance_id to be the aws instance id
    
      *hint* go to https://www.terraform.io/docs/index.html > Providers > AWS to see documentation
      
    The new complete main.tf is below
        
    ```hcl-terraform
    # main.tf
    variable "my_name" {
    }
    provider "aws" {
        region = "us-east-2"
    }
    resource "aws_instance" "first_instance" {
        instance_type = "t2.micro"
        ami = "ami-050553a7784d00d21"
        tags {
          "Name" = "${var.my_name}"
        }
    }    
    output "instance_id" {
      value = "${aws_instance.my_instance.id}"
    }
    ```
    
10. Run **terraform init** to download the AWS provider
 
    `terraform init`
    
    which should download the aws provider to the project's .terraform directory
    ```
    Initializing provider plugins...
    ...
    * provider.aws: version = "~> 1.54"

    Terraform has been successfully initialized!
    ...
    ```
11. Run **terraform plan** to see what will happen if we apply

    `terraform plan`
    
    Because we didnt specify the variable name on the command line, we are prompted for it
    
    ```
    $ terraform plan
    var.my_name
      Enter a value: Brian Peterson

    Refreshing Terraform state in-memory prior to plan...
    The refreshed state will be used to calculate this plan, but will not be
    persisted to local or remote state storage.


    ------------------------------------------------------------------------

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      + aws_instance.my_instance
          id:                           <computed>
          ami:                          "ami-050553a7784d00d21"
          arn:                          <computed>
          associate_public_ip_address:  <computed>
          availability_zone:            <computed>
          cpu_core_count:               <computed>
          cpu_threads_per_core:         <computed>
          ebs_block_device.#:           <computed>
          ephemeral_block_device.#:     <computed>
          get_password_data:            "false"
          host_id:                      <computed>
          instance_state:               <computed>
          instance_type:                "t2.micro"
          ipv6_address_count:           <computed>
          ipv6_addresses.#:             <computed>
          key_name:                     <computed>
          network_interface.#:          <computed>
          network_interface_id:         <computed>
          password_data:                <computed>
          placement_group:              <computed>
          primary_network_interface_id: <computed>
          private_dns:                  <computed>
          private_ip:                   <computed>
          public_dns:                   <computed>
          public_ip:                    <computed>
          root_block_device.#:          <computed>
          security_groups.#:            <computed>
          source_dest_check:            "true"
          subnet_id:                    <computed>
          tags.%:                       "1"
          tags.Name:                    "Brian Peterson"
          tenancy:                      <computed>
          volume_tags.%:                <computed>
          vpc_security_group_ids.#:     <computed>


    Plan: 1 to add, 0 to change, 0 to destroy.

    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.
    
    ```
12. Run **terraform appy** to deploy the resources
 
    `terraform apply`
    
    Terraform will prompt you for a "yes" to make sure that you want to execute the operation
    
    When complete, terraform will output the instance_id
    
    Plug your instance_id into the command below to see your instance in AWS 
    
    `aws ec2 describe-instances --filters 'Name=instance-id,Values=INSERT_INSTANCE_ID_HERE'`
    
    or Plug in your name in the command below to see your instance
    
    `aws ec2 describe-instances --filters 'Name=tag:Name,Values="INSERT_YOUR_NAME_HERE"'`
    
    *cli tip*: install the jq json parser to make the AWS and azure CLI's easy to parse
    
      Windows run `choco install jq` and Mac users run `brew install jq` and linux users, you know what to do
    
    `aws ec2 describe-instances --filters 'Name=instance-id,Values=INSERT_INSTANCE_ID_HERE' | jq .Reservations[].Instances[].Tags`
    
    Or use ADFS to go to the AWS account's console > EC2 > Ohio Region
    
    ![bp instances](images/bp_inst.png)
    
13. Statically set the default value to the "my_name" variable in your main.tf

    Make a change to the variable 

    ```
    variable "my_name" {
      default = "Brian Peterson, aka terraformer"
    }
    ```
    
14. Run a `terraform plan` to see what will happen

    ```hcl-terraform
    $ terraform plan
    Terraform will perform the following actions:

      ~ aws_instance.my_instance
          tags.Name: "Brian Peterson" => "Brian Peterson, aka terraformer"


    Plan: 0 to add, 1 to change, 0 to destroy.

    ```

15. Apply the change using `terraform apply -auto-approve`

    ```hcl-terraform
    $ terraform apply -auto-approve
    aws_instance.my_instance: Refreshing state... (ID: i-02abd470f1d011a17)
    aws_instance.my_instance: Modifying... (ID: i-02abd470f1d011a17)
      tags.Name: "Brian Peterson" => "Brian Peterson, aka terraformer"
    aws_instance.my_instance: Modifications complete after 3s (ID: i-02abd470f1d011a17)

    Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

    Outputs:

    instance_id = i-02abd470f1d011a17

    ```

16. And check the tag value in AWS
 
   ```
    $ aws ec2 describe-instances --filters 'Name=instance-id,Values=INSERT_INSTANCE_ID_HERE' | jq .Reservations[].Instances[].Tags`
    [
      {
        "Value": "Brian Peterson, aka terraformer",
        "Key": "Name"
      }
    ]
   ``` 
   
17. Finally, destroy your resources using `terraform destroy`
 
    ```hcl-terraform
    $ terraform destroy
    aws_instance.my_instance: Refreshing state... (ID: i-02abd470f1d011a17)


    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      - destroy

    Terraform will perform the following actions:

      - aws_instance.my_instance


    Plan: 0 to add, 0 to change, 1 to destroy.

    Do you really want to destroy all resources?
      Terraform will destroy all your managed infrastructure, as shown above.
      There is no undo. Only 'yes' will be accepted to confirm.

      Enter a value: yes

    aws_instance.my_instance: Destroying... (ID: i-02abd470f1d011a17)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 10s elapsed)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 20s elapsed)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 30s elapsed)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 40s elapsed)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 50s elapsed)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 1m0s elapsed)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 1m10s elapsed)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 1m20s elapsed)
    aws_instance.my_instance: Still destroying... (ID: i-02abd470f1d011a17, 1m30s elapsed)
    aws_instance.my_instance: Destruction complete after 1m35s

    Destroy complete! Resources: 1 destroyed.
    ```
