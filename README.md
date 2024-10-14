Project Summary : Deployment of Two AWS EC2 Instances Using Terraform

Overview of Terraform : Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp, enabling users to define and provision infrastructure using declarative configuration files. It allows for version control of infrastructure, automated deployments, and seamless management of cloud resources. In this project, Terraform is utilized to provision and manage two AWS EC2 instances in a repeatable and efficient manner.

Step-by-Step Guide to Deploying EC2 Instances via Terraform: 

1 > Set Up Your Environment:
- Ensure you have Terraform installed on your machine. You can download it from the Terraform website.
curl -O https://releases.hashicorp.com/terraform/{VERSION}/terraform_{VERSION}_linux_amd64.zip
unzip terraform_{VERSION}_*.zip
sudo mv terraform /usr/local/bin/
terraform version 

               OR

Installing Terraform on Ubuntu via APT: Update the Package Repository: Open your terminal and update the package list to ensure you have the latest information about available packages:
sudo apt update
Install Required Packages: Install unzip if it is not already installed, as it will be needed to extract the Terraform binary:

sudo apt install -y unzip
Add the HashiCorp GPG Key: Import the HashiCorp GPG key to verify the packages:

wget -qO- https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
Add the HashiCorp APT Repository: Add the HashiCorp repository to your APT sources list:

echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
Update the Package Repository Again: After adding the new repository, update your package list:

sudo apt update
Install Terraform: Now, you can install Terraform using the following command:

sudo apt install terraform
Verify Installation: Check that Terraform is installed correctly by running:

terraform version

- Configure your AWS credentials. You can set this up by running aws configure and entering your AWS Access Key, Secret Key, and default region.
Create an IAM user give it the admin access.
Go to "Security Credentials" of that user, click on "Create Access Key" for CLI use case and retrieve the Access Key and Secret Access Key.
Go to your terminal type "aws configure" and enter the "Access key" and "Secret Access Key" and keep the rest paramters at default, hit enter.


2 > Create the main.tf File:

Create a directory for your Terraform project and navigate into it. Inside this directory, create a file named main.tf and copy the provided Terraform configuration into it.

Understand the Configuration of your .tf file, which in our case is main.tf. Go to the "main.tf" file of this repository for the code. Below is brief explanation of each blocks, parameters and arguements,etc.

Terraform Block: Specifies the required provider, which is AWS in this case, and the version of the provider.
Provider Block: Configures the AWS provider, specifying the region (us-east-1) where the resources will be deployed.
Key Pair: Creates an AWS key pair using the public key located at /home/ubuntu/.ssh/mykey.pub, which will be used to access the EC2 instances.
Default VPC: Sets up a default VPC to deploy the EC2 instances.
Security Group: Defines a security group (allow_traffic) that allows inbound SSH traffic on port 22 from all IP addresses (0.0.0.0/0).
EC2 Instance Resource: Provisions two EC2 instances (my_ec2) of type t2.micro using a specified Amazon Machine Image (AMI). Each instance is tagged uniquely using the count.index.

3 > Initialize Terraform :  terraform init
 
4 > Plan the Deployment: Generate an execution plan to preview the changes Terraform will make to your infrastructure. Run:
- terraform plan

5 > Apply the configuration to deploy the EC2 instances. Run:
- terraform apply

You will be prompted to confirm the changes. Type yes to proceed.

6 > Once the deployment is complete, log in to the AWS Management Console and navigate to the EC2 Dashboard. You should see two EC2 instances running with the tags SecuredInstance-1 and SecuredInstance-2.

7 > Connect to Your EC2 Instances: Use SSH to connect to your EC2 instances using the private key associated with the key pair you created. The command will look like:

ssh -i /home/ubuntu/.ssh/mykey ubuntu@<Public_IP_of_Instance>
Replace <Public_IP_of_Instance> with the public IP address of the instance you wish to connect to.

8 > Clean Up Resources: After testing, if you want to remove the created resources, run:
- terraform destroy

Confirm by typing yes when prompted.

This project demonstrates how to effectively use Terraform to deploy AWS resources in a controlled and reproducible manner. By defining infrastructure in code, you can easily manage, scale, and update your deployments while ensuring consistency across your environment.
