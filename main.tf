
##################################################
# Create Security Groups for FTDv instance
##################################################
resource "aws_security_group" "SG_Data" {
  name        = "Allow All"
  description = "Allow all traffic"
  vpc_id      = var.az1

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_DATA"
  }
}

resource "aws_security_group" "SG_Mgmt" {
  name        = "managementSG"
  description = "SG for management"
  vpc_id      = var.az1

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8305
    to_port     = 8305
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SG_MGMT"
  }
}
############################################################
# Creating management interfaces(with EIP) for FTDv instance
############################################################

resource "aws_network_interface" "az1_management" {
  count               = var.az1_instance_count
  subnet_id           = var.az1_mgmt
  security_groups     = [aws_security_group.SG_Mgmt.id]
  source_dest_check   = false
  tags = {
    Name = "az1_FTDMgmt"
  }
}

resource "aws_network_interface" "az2_management" {
  count               = var.az2_instance_count
  subnet_id           = var.az2_mgmt
  security_groups     = [aws_security_group.SG_Mgmt.id]
  source_dest_check   = false
  tags = {
    Name = "az2_FTDMgmt"
  }
}
##################################################
# Creating diagnostic interfaces for FTDv instance
##################################################
resource "aws_network_interface" "az1_diagnostic" {
  count               = var.az1_instance_count
  subnet_id           = var.az1_diag
  security_groups     = [aws_security_group.SG_Mgmt.id]
  source_dest_check   = false
  tags = {
    Name = "az1_FTDDiag"
  }
}
resource "aws_network_interface" "az2_diagnostic" {
  count               = var.az2_instance_count
  subnet_id           = var.az2_diag
  security_groups     = [aws_security_group.SG_Mgmt.id]
  source_dest_check   = false
  tags = {
    Name = "az2_FTDDiag"
  }
}
##############################################
# Creating inside interfaces for FTDv instance
##############################################
resource "aws_network_interface" "az1_inside" {
  count               = var.az1_instance_count
  subnet_id           = var.az1_inside
  security_groups     = [aws_security_group.SG_Data.id]
  source_dest_check   = false
  tags = {
    Name = "az1_FTDInside"
  }

  attachment {
    instance     = aws_instance.az1_ftdv[count.index].id
    device_index = 2
  }

}

resource "aws_network_interface" "az2_inside" {
  count               = var.az2_instance_count
  subnet_id           = var.az2_inside
  security_groups     = [aws_security_group.SG_Data.id]
  source_dest_check   = false
  tags = {
    Name = "az2_FTDInside"
  }

  attachment {
    instance     = aws_instance.az2_ftdv[count.index].id
    device_index = 2
  }

}
###########################################################
# Creating outside interfaces (without EIP) for FTDv instance
###########################################################
resource "aws_network_interface" "az1_outside" {
  count               = var.az1_instance_count
  subnet_id           = var.az1_outside
  security_groups     = [aws_security_group.SG_Data.id]
  source_dest_check   = false
  tags = {
    Name = "az1_FTDOutside"
  }

  attachment {
    instance     = aws_instance.az1_ftdv[count.index].id
    device_index = 3
  }

}
resource "aws_network_interface" "az2_outside" {
  count               = var.az2_instance_count
  subnet_id           = var.az2_outside
  security_groups     = [aws_security_group.SG_Data.id]
  source_dest_check   = false
  tags = {
    Name = "az2_FTDOutside"
  }

  attachment {
    instance     = aws_instance.az2_ftdv[count.index].id
    device_index = 3
  }

}

################################################
# Attach Key Pair
################################################

resource "aws_key_pair" "localkey" {
  key_name = "madewang-region-key-pair"
  public_key = "${file("madewang-region-key-pair.pub")}"
}

################################################
# Deploying FTDv instances (MultipleAZ deployment)
################################################

data "template_file" "initial_ftd_config" {
  template = file("config.json")
}

resource "aws_instance" "az1_ftdv" {
  count                  = var.az1_instance_count
  ami                    = var.region_ami[var.region]
  instance_type          = var.instance_type

  key_name               = "${aws_key_pair.localkey.id}"
  monitoring             = true
  user_data              = data.template_file.initial_ftd_config.rendered

  network_interface{
    device_index = 0
    network_interface_id = aws_network_interface.az1_management[count.index].id
  }
  network_interface{
    device_index = 1
    network_interface_id = aws_network_interface.az1_diagnostic[count.index].id
  }

  tags = {
    Name = "az1FirepowerNGFWv"
  }
}

resource "aws_instance" "az2_ftdv" {
  count                  = var.az2_instance_count
  ami                    = var.region_ami[var.region]
  instance_type          = var.instance_type

  key_name               = "${aws_key_pair.localkey.id}"
  monitoring             = true
  user_data              = data.template_file.initial_ftd_config.rendered

  network_interface{
    device_index = 0
    network_interface_id = aws_network_interface.az2_management[count.index].id
  }
  network_interface{
    device_index = 1
    network_interface_id = aws_network_interface.az2_diagnostic[count.index].id
  }

  tags = {
    Name = "az2FirepowerNGFWv"
  }
}