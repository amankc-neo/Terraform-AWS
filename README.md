Project Summary : Deployment of Two AWS EC2 Instances Using Terraform

Overview of Terraform : Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp, enabling users to define and provision infrastructure using declarative configuration files. It allows for version control of infrastructure, automated deployments, and seamless management of cloud resources. In this project, Terraform is utilized to provision and manage two AWS EC2 instances in a repeatable and efficient manner.

Step-by-Step Guide to Deploying EC2 Instances via Terraform: 

1 > Set Up Your Environment:
Ensure you have Terraform installed on your machine. You can download it from the Terraform website.

Configure your AWS credentials. You can set this up by running aws configure and entering your AWS Access Key, Secret Key, and default region.

2 > Create the main.tf File:

Create a directory for your Terraform project and navigate into it. Inside this directory, create a file named main.tf and copy the provided Terraform configuration into it.
Understand the Configuration:

Terraform Block: Specifies the required provider, which is AWS in this case, and the version of the provider.
Provider Block: Configures the AWS provider, specifying the region (us-east-1) where the resources will be deployed.
Key Pair: Creates an AWS key pair using the public key located at /home/ubuntu/.ssh/mykey.pub, which will be used to access the EC2 instances.
Default VPC: Sets up a default VPC to deploy the EC2 instances.
Security Group: Defines a security group (allow_traffic) that allows inbound SSH traffic on port 22 from all IP addresses (0.0.0.0/0).
EC2 Instance Resource: Provisions two EC2 instances (my_ec2) of type t2.micro using a specified Amazon Machine Image (AMI). Each instance is tagged uniquely using the count.index.
Initialize Terraform:

Run the following command to initialize your Terraform environment. This command downloads the necessary provider plugins specified in your configuration.
bash
Copy code
terraform init
Plan the Deployment:

Generate an execution plan to preview the changes Terraform will make to your infrastructure. Run:
bash
Copy code
terraform plan
Apply the Configuration:

Apply the configuration to deploy the EC2 instances. Run:
bash
Copy code
terraform apply
You will be prompted to confirm the changes. Type yes to proceed.
Verify Deployment:

Once the deployment is complete, log in to the AWS Management Console and navigate to the EC2 Dashboard. You should see two EC2 instances running with the tags SecuredInstance-1 and SecuredInstance-2.
Connect to Your EC2 Instances:

Use SSH to connect to your EC2 instances using the private key associated with the key pair you created. The command will look like:
bash
Copy code
ssh -i /home/ubuntu/.ssh/mykey ubuntu@<Public_IP_of_Instance>
Replace <Public_IP_of_Instance> with the public IP address of the instance you wish to connect to.
Clean Up Resources:

After testing, if you want to remove the created resources, run:
bash
Copy code
terraform destroy
Confirm by typing yes when prompted.
Conclusion
This project demonstrates how to effectively use Terraform to deploy AWS resources in a controlled and reproducible manner. By defining infrastructure in code, you can easily manage, scale, and update your deployments while ensuring consistency across your environment.
