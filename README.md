# Cisco Firepower Threat Defense Deployment in AWS to secure transaction between multiple Availability Zones
Terraform module to deploy a given number of FTDv appliances in AWS in a Multiple Availability Zone


<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Author](#author)
* [Disclaimer](#disclaimer)
* [Pre-Requisite](#pre-requisite)
* [Usage](#usage)
* [HowTo](#how-tos)
* [RequiredChanges](#changes-to-be-made-in-the-template-for-consuming)
* [Assumption](#assumption)

# Authors
Modules are maintained by Madhuri Dewangan (madewang@cisco.com)

# Disclaimer
This terraform Template is not an officially supported Cisco product. For official Cisco NGFWv documentation visit the [page](https://www.cisco.com/c/en/us/td/docs/security/firepower/quick_start/aws/ftdv-aws-gsg.html).


# Pre-Requisite
Make sure the client from where the template is being executed has terraform installed.

# Usage
Please Note: Before using the template update the provider.tf file with access key and secret key, and config.json with the FMC IP.
1. Run ssh-keygen -f ftd-key-pair .
2. In Step one you can change the key pair name.
3. Note the path where the .pub file is located and edit in the file main.tf under "Attach Key Pair" Section
4. Edit content in variable.tf and terraform.tfvars file.
5. Run command to get the terraform plan "terraform plan -out terraform.out"
6. Finally execute the "terraform apply terraform.out"

# How-Tos
1. Get the Image ID used in variable.tf for region-ami

This can be obtained from the deployement page of FTDv in AWS.



# Changes to be made in the Template for consuming
1. Change the contents in variable.tf and terraform.tfvars
2. Follow through main.tf . All the changes required and necessary has been explained there.

# Assumption
- This template is developed keeping in mind that the Cloud Team would be already ready with VPC, subnet, route tables and transit gateway configuration.
- This template will be utilizing those information and building the required NGFWs in AWS environment.
- User will have to modify the naming convention of the resources as per the Policy.
- User of this template will be having the access key and secret key for the service account with required permission to build the instances in AWS.







