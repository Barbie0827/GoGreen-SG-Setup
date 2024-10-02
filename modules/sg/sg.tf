# Bastion Security Group
module "bastion_security_group" {
  source  = "app.terraform.io/0227springcloud/security-groups/aws"
  version = "1.0.0"

  vpc_id = aws_vpc.vpc.id
  security_groups = {
    "bastion_sg" : {
      description   = "Security group for bastion host"
      ingress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = [var.my_ip]  # Adjust to your needs
        }
      ]
      egress_rules = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}
 
# Web Security Group
module "web_security_group" {
  source  = "app.terraform.io/0227springcloud/security-groups/aws"
  version = "1.0.0"
  
  vpc_id = module.vpc.id
 
  security_groups = {
    "web_sg" = {
      description   = "Security group for web"
      ingress_rules = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port       = 22
          to_port         = 22
          protocol        = "tcp"
          security_groups = [module.bastion_security_group.security_group_id["bastion_sg"]]
        }
      ]
      egress_rules = [
        {
          description = "egress rule"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}
 
 
# App Security Group
module "app_security_group" {
  source  = "app.terraform.io/0227springcloud/security-groups/aws"
  version = "1.0.0"
  
  vpc_id = module.vpc.id
 
  security_groups = {
    "app_sg" = {
      description   = "Security group for app instances"
      ingress_rules = [
        {
          from_port       = 8080
          to_port         = 8080
          protocol        = "tcp"
          security_groups = [module.web_security_group.security_group_id["web_sg"]]
        },
        {
          from_port       = 22
          to_port         = 22
          protocol        = "tcp"
          security_groups = [module.web_security_group.security_group_id["bastion_sg"]]
        }
      ]
      egress_rules = [
        {
          description = "egress rule"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },
    "app_elb_sg" = {
      description   = "Security group for ALB"
      ingress_rules = [
        {
          from_port       = 8080
          to_port         = 8080
          protocol        = "tcp"
          security_groups = [module.web_security_group.security_group_id["web_sg"]]
        }
      ]
      egress_rules = [
        {
          description = "egress rule"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}
 
 
 
# Database Security Group
module "db_security_group" {
  source  = "app.terraform.io/0227springcloud/security-groups/aws"
  version = "1.0.0"
  
  vpc_id = module.vpc.id
  security_groups = {
    "db_sg" = {
      description   = "Security group for database"
      ingress_rules = [
        {
          
          from_port   = 3306 #database mysql port
          to_port     = 3306
          protocol    = "tcp"
          security_groups = ["module.app_security_group.security_group_id"["app_sg"]]  
        }
      ]
      egress_rules = [
        {
          description = "egress rule"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}