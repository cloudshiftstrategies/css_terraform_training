# Creating cloud creds for TFE

Use the following procedures to create cloud credentials for tfe.

See [this 301 level tip](tfe301.md#tfe-credentials) on secure ways to manage and push the creds to to the workspace

### AWS 
Do not use your personal IAM user access keys, or an STS assume role access key (i.e. from a SAML assertion).
    
To create the access keys, run the following commans using the AWS CLI
```hcl
aws iam create-user --user-name terraform
aws iam attach-user-policy --user-name terraform --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam create-access-key --user-name terraform
```
Which will return something like this
```json
{
  "AccessKey": {
    "UserName": "terraform", 
    "Status": "Active", 
    "CreateDate": "2019-01-08T00:03:00Z", 
    "SecretAccessKey": "xT31CLqXXXXXXXXXXXXXXXXXXXXXXXXXXADEGjAxGXG", 
    "AccessKeyId": "AKIXXXXXXXXXXXXXP37A"
  }
}  
```

* AWS_ACCESS_KEY_ID is the AccessKeyId: above
* AWS_SECRET_ACCESS_KEY is the SecretAccessKey: above

### Azure

Login to your MS account with the  azure cli
    
`az login`
    
Get a list of azure subscriptions to which you have access
`az account list`
   
For the subscription you'd like to create a role, run the following command 
`az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID_HERE"`
    
which will return something like the following
```json
{
  "appId": "c8bXXXXX-XXXX-XXXX-XXXX-XXXXXc27a22b",
  "displayName": "azure-cli-2018-09-24-16-52-39",
  "name": "http://azure-cli-2018-09-24-16-52-39",
  "password": "b8XXXXXX-XXXX-XXXX-XXXX-XXXXX792542f",
  "tenant": "6b0XXXXX-XXXX-XXXX-XXXX-XXXXXX225fbd"
}
```

* ARM_SUBSCRIPTION_ID is the id: from `az account list`
* ARM_CLIENT_ID is the appId: from the output above
* ARM_TENANET_ID is the tenant: from the output above
* ARM_CLIENT_SECRET is the password: from the output above
