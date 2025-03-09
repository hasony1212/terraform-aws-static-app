
locals {
  tags = {
    Application_Name = var.domain
    Approver         = "approver"
    Environment      = var.env_name
    Business_Uint    = var.domain
  }
}


#Calling the Module 
module "s3_static_site" {
  source           = "../s3-static-site"
  domain           = var.domain
  env_name         = var.env_name
  aws_region = var.aws_region
  tags             = local.tags
}
