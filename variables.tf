# define GCP project name
variable "project" {
  type = string
  description = "GCP project name"
  default = "jitendralab"
}

# define GCP region
variable "region" {
  type = string
  description = "GCP region"
  default     = null
}
# define GCP zone
variable "zone" {
  type = string
  description = "GCP zone"
  default     = null
}
/*
# define private subnet
variable "private_subnet_cidr_1" {
  type = string
  description = "private_subnet_CIDR 1"
  default     = null
}
*/
 /*  This is in case of Count loop for List of Any  
variable "private-subnet" {
  description = "Create private subnets with these names"
  type        = list(any)
  default     = null
}
*/
variable "private-subnet" {
  description = "Create private subnets with these names"
  type        = map(any)
  default     = null
}
# define application name
variable "app_name" {
  type = string
  description = "Application name"
  default     = null
}
