##App Config  

variable "domain" {
  type        = string
  description = "A list of naked domains to be built into a static website."
}

variable "env_name" {
  type        = string
  description = "Environment name used all resources in this module"

}


variable "aws_region" {
  type        = string
  description = "aws region to deoply to"
  default     = "us-east-1"

}

##  Environment Config / Tags 
variable "tags" {
  description = "Tags Environment name used all resources in this module"

}

variable "cloudfront-authentication-user-agent" {
  default = "V3ryS3cretString"
}

# DB Config
