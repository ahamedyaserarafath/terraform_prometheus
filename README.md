# Terraform prometheus and Grafana - Provisioni and deploy the Prometheus and Grafana on AWS using Terraform and Docker.
- [Introduction](#Introduction)
- [Pre-requisites](#pre-requisites)
- [Installation and configuration](#Installation-and-configuration)
- [Result](#Result)

# Introduction
In this post, we will deploy a prometheus docker to AWS. We will use Terraform to provision a series of Elastic Cloud Compute (EC2) instances.
The instances will be built from a basic ubuntu 18.04 ami. We will install the docker and deploy the prometheus.

# Pre-requisites
Before we get started installing the Prometheus stack on AWS. 
* Ensure you install the latest version of [terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) is installed
* Create the IAM access in AWS to provision the ec2 instance,vpc,subnet,internet gateway,security group,iam.

# Installation and configuration
Clone the project locally to your Docker host.

If you would like to change which targets should be monitored or make configuration changes edit the prometheus.yml file. 
The targets section is where you define what should be monitored by Prometheus(By default it monitor the EC2 instance) 

The AWS will provision and those are added as a part of variables, if you wish to change please feel free to change in variable.tf alone.

In this project we used the following provision.
* EC2 AMI - ami-0dad20bd1b9c8c004 
* EC2 Instance Type - t2.micro
* Region - Singapore
* VPC - 11.0.0.0/16
* Subnet - 11.0.1.0/24
* Port Opened - 3000, 9090

# Steps to run the provisioning in terraform
1. Clone the repo
```
git clone https://github.com/ahamedyaserarafath/terraform_promethus.git
```
2. Terraform initialize a working directory 
```
terraform init
```
3. Terraform to create an execution plan
```
terraform plan
```
4. Terraform apply to provision in aws
```
terraform apply
```
Note: The above command will provision the ec2 instance and install the prometheus

# Result
```
Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

Grafana_URL = http://54.169.85.67:3000
Prometheus_URL = http://54.169.85.67:9090
```

