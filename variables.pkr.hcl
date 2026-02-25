# Auth variables
variable "tenancy_ocid" {
  type        = string
  description = "OCI Tenancy OCID"
}

variable "user_ocid" {
  type        = string
  description = "OCI User OCID"
}

variable "fingerprint" {
  type        = string
  description = "OCI API key fingerprint"
}

variable "key_file" {
  type        = string
  description = "Absolute path to OCI API private key PEM file on the build runner"
}

# Instance variables
variable "availability_domain" {
  type        = string
  description = "The OCI Availability Domain to launch the instance in"
}

variable "compartment_ocid" {
  type        = string
  description = "The OCID of the compartment where the instance will run"
}

variable "subnet_ocid" {
  type        = string
  description = "The OCID of the subnet to launch the instance in"
}

variable "region" {
  type        = string
  description = "The OCI region where the image will be built"
}

variable "instance_shape" {
  type        = string
  description = "Compute shape for the build instance"
  default     = "VM.Standard.E4.Flex"
}

variable "image_name_prefix" {
  type        = string
  description = "Prefix for the output custom image name"
  default     = "ubuntu-base-image"
}
