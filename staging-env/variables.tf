variable "domain" {
  type        = string
  description = "domains to be built into a static website."
}

variable "aws_region" {
  type        = string
  description = "aws region to deoply to"
  default     = "us-east-1"
}

variable "env_name" {
  type        = string
  description = "Environment name used all resources in this module"

}


