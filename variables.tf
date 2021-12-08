#################################
#        Define Nameing Convention
#################################
variable "name" {
  description = "AWS object name prefix"
  type     = string
}
#################################
#        Define region
#################################

variable "region" {
  description = "AWS region name"
  type     = string
  default      = "us-east-2" #chnage this to the region where the devices needs to be deployed
}

######################################################
# Define VPC ID where you want to launch the instance
######################################################
variable "az1" {
  description = "Enter VPC ID to launch the FTD Appliances"
  type        = string
  default     = "vpc-011ec5a1b2eea821b"
}

################################################################
# Define Availability Zone where you want to launch the instance
################################################################

variable "azone1" {
  description = "Availability Zone"
  default     = "us-east-2a"
  type        = string
}

variable "azone2" {
  description = "Availability Zone"
  default     = "us-east-2c"
  type        = string
}

################################################################
# Define Subnets IP  which will be attached to the instance
################################################################

variable "az1_mgmt_ip" {
  description = "Outside subnet IP for firewall "
  type        = list(string)
}

variable "az1_diag_ip" {
  description = "Inside subnet IP for firewall "
  type        = list(string)
}

variable "az1_inside_ip" {
  description = "Management subnet IP for firewall"
  type        = list(string)
}
variable "az1_outside_ip" {
  description = "Management subnet IP for firewall"
  type        = list(string)
}

variable "az2_mgmt_ip" {
  description = "Outside subnet IP for firewall"
  type        = list(string)
}

variable "az2_diag_ip" {
  description = "Inside subnet for IP firewall"
  type        = list(string)
}

variable "az2_inside_ip" {
  description = "Management subnet IP for firewall"
  type        = list(string)
}
variable "az2_outside_ip" {
  description = "Management subnet IP for firewall"
  type        = list(string)
}
################################################################
# Define Subnet which will be attached to the instance
################################################################
variable "az1_mgmt" {
  description = "Outside subnet for firewall (ex- 22.0.1.0/24)"
  type        = string
}

variable "az1_diag" {
  description = "Inside subnet for firewall (ex- 22.0.2.0/24)"
  type        = string
}

variable "az1_inside" {
  description = "Management subnet for firewall (ex- 22.0.3.0/24)"
  type        = string
}
variable "az1_outside" {
  description = "Management subnet for firewall (ex- 22.0.3.0/24)"
  type        = string
}

variable "az2_mgmt" {
  description = "Outside subnet for firewall (ex- 22.0.1.0/24)"
  type        = string
}

variable "az2_diag" {
  description = "Inside subnet for firewall (ex- 22.0.2.0/24)"
  type        = string
}

variable "az2_inside" {
  description = "Management subnet for firewall (ex- 22.0.3.0/24)"
  type        = string
}
variable "az2_outside" {
  description = "Management subnet for firewall (ex- 22.0.3.0/24)"
  type        = string
}

################################################################
# Define Key to be used for the Build
################################################################

variable "key_name" {
  description = "AWS keypair name"
  default     = "Kubekey"
  type        = string
}



########################
# Define Instance count
########################
variable "az1_instance_count" {
  description = "Number of firewall appliances"
  default     = 1
  type        = number
}

variable "az2_instance_count" {
  description = "Number of firewall appliances"
  default     = 1
  type        = number
}

########################
# Define Instance type
########################

variable "instance_type" {
  description = "Instance types"
  default     = "c4.xlarge"
  type        = string
}
###########################
# Define Security Group ID
###########################
variable "SG_Mgmt" {
  description = "Instance types"
  default     = "sg-0159c6953dce6476b"
  type        = string
}
variable "SG_Data" {
  description = "Instance types"
  default     = "sg-0f8383ed8cd99f656"
  type        = string
}

##########################################
# Define Image ID to be used for the build
##########################################


variable "region_ami" {
  type        = map(string)
  default     = {
    eu-central-1   = "ami-need to update these values"
    eu-north-1     = "ami-need to update these values"
    eu-west-1      = "ami-need to update these values"
    eu-west-2      = "ami-need to update these values"
    eu-west-3      = "ami-need to update these values"
    us-east-1      = "ami-07e4a27f672a46522"
    us-east-2      = "ami-067247187160ec69c"
    us-west-1      = "ami-need to update these values"
    us-west-2      = "ami-need to update these values"
    sa-east-1      = "ami-need to update these values"
    ap-northeast-1 = "ami-need to update these values"
    ap-northeast-2 = "ami-need to update these values"
    ap-south-1     = "ami-need to update these values"
    ap-southeast-1 = "ami-need to update these values"
    ap-southeast-2 = "ami-need to update these values"
    ca-central-1   = "ami-need to update these values"
  }
}
