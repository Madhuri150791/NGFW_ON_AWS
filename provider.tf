#################################
# Cloud Provider details: AWS
#################################
provider "aws" {
  profile     = "default"
  region      = var.region
  access_key = " " # update this using own access key
  secret_key = " "  # update this using own secret key
}
