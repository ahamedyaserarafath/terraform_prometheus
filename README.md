# Terraform - prometheus - Grafana
# Provision and deploy the Prometheus and Grafana on AWS using Terraform and Docker.
- [Introduction](#Introduction)
- [Pre-requisites](#pre-requisites)
- [Installation and configuration](#Installation-and-configuration)
- [Result](#Result)
- [Node Exporter](#Node Exporter)


# Introduction
In this post, we will deploy a prometheus docker to AWS. We will use Terraform to provision a series of Elastic Cloud Compute (EC2) instances.
The instances will be built from a basic ubuntu 18.04 ami. We will install the docker and deploy the prometheus.
The Prometheus will discover the ec2 instance in the singapore region(If you wish to change please add the respective region in yml file)

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

In this project the prometheus will discover the ec2 instance across the singapore region.

# Steps to run the provisioning in terraform
1. Clone the repo
```
git clone https://github.com/ahamedyaserarafath/terraform_prometheus.git
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

# Node Exporter
Now Grafana and prometheus is up and running. Now its time to run the node-exporter in the ec2 nodes which will the send the metrics to prometheus.

```
cd node-exporter
./node_exporter.sh
```

Node exporter by default send the metrics in 9100 and now you can see those metrics in prometheus and grafana(is used only for ui dashboard)


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.prometheus_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.prometheus_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.prometheus_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_instance.prometheus_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.prometheus_ig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.prometheus_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route.prometheus_internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.prometheus_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.prometheus_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.prometheus_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.prometheus_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.prometheus_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [tls_private_key.sskeygen_execution](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_amis"></a> [aws\_amis](#input\_aws\_amis) | Ubuntu Server 18.04 LTS (HVM), SSD Volume Type | `map` | <pre>{<br>  "ap-southeast-1": "ami-0dad20bd1b9c8c004"<br>}</pre> | no |
| <a name="input_aws_availability_zone"></a> [aws\_availability\_zone](#input\_aws\_availability\_zone) | AWS availabitiy zone to launch servers. | `string` | `"ap-southeast-1a"` | no |
| <a name="input_aws_instance_type"></a> [aws\_instance\_type](#input\_aws\_instance\_type) | AWS Instance type | `string` | `"t2.micro"` | no |
| <a name="input_aws_public_key_name"></a> [aws\_public\_key\_name](#input\_aws\_public\_key\_name) | n/a | `string` | `"prometheus_aws_rsa"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to launch servers. | `string` | `"ap-southeast-1"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | `"Prod"` | no |
| <a name="input_name"></a> [name](#input\_name) | Infrastructure name | `string` | `"Promethus_Server"` | no |
| <a name="input_prometheus_access_name"></a> [prometheus\_access\_name](#input\_prometheus\_access\_name) | n/a | `string` | `"prometheus_ec2_access"` | no |
| <a name="input_prometheus_server_subnet_cidr1"></a> [prometheus\_server\_subnet\_cidr1](#input\_prometheus\_server\_subnet\_cidr1) | Promethus Server Subnet CIDR | `string` | `"11.0.1.0/24"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR | `string` | `"11.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Grafana_URL"></a> [Grafana\_URL](#output\_Grafana\_URL) | n/a |
| <a name="output_Prometheus_URL"></a> [Prometheus\_URL](#output\_Prometheus\_URL) | n/a |
<!-- END_TF_DOCS -->