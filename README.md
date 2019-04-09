https://zenodo.org/badge/154329157.svg

# AutomationTooling2018-19Project
Housing Terraform and CloudFormation configuration + more to come. This project serves as an investigation for a final year Bsc Dissertation. Any code and tool usability will be discussed in detail on the physical report. 

## Sample Topology
The following topology will be used for the infrastructure orchestration:

![Alt text](DocResources/sampleT.png?raw=true "Sample Topology")

## Preperation

Ahead of time, ensure you have an IAM user set up with programmatic access (access and secret key) on your AWS account

1. Install the AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
2. Install Terraform: https://www.terraform.io/downloads.html

## Setting up Terraform

1. Terraform looks for a configured profile usually located in the `.aws`        directory of a users home directory. 
    
    To set this up, you will need to run the 
`aws configure` 

2. Configure an S3 bucket in AWS and take note of the bucket name. 


    Replace the bucket name and the region so that they match the account being used. 
    ```terraform
    terraform {
    backend "s3" {
        bucket = "2018-19tfstatesproject"
        key    = "terraform.state"
        region = "eu-west-1"
    }
    }
    ```

3. Generate an ssh key (using RSA). This will be used to ssh into the ec2 boxes. Once generated, You will be required to replace the **_"default public key"_** which can be found at: 



    `modules/ComputeR/variables`

4. Initialise the project - Go to the WebServerMain Directory. Run the following code to initialise the project. 

    `terraform init`

    This will set up any requirments by terraform and the provider used within the terraform files. Including the backed linking to your newly created s3 bucket. If you missed this part, go back to step 2!

5. You are ready to experience the project! the following cli commands will be useful to you since there are a few dependencies within the code.

    The following command will run a plan with a custom provided enviornment file. In a production case, there may be multiple of these files that can be used to alter the outcome of the infrastructure at once. 

    `terraform plan -var-file="../env.tfvars"`

    The following command also applies, but instead of a plan, will run and attempt to build the infrastructure according to the instructions from the code we wrote 

    `terraform apply -var-file="../env.tfvars"`
    ```

    Run the following commands in the order given  (if done correctly, there will be no exceptions)

    a.)

    b.) 

    c.)

^^^^ to be Written up Soon ^^^^
