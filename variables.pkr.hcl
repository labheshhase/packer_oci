variable "availability_domain" {
  type        = string
  description = "The OCI Availability Domain to launch the instance in."
}

variable "compartment_ocid" {
  type        = string
  description = "The OCID of the compartment where the instance will run and the image will be stored."
}

variable "instance_shape" {
  type        = string
  description = "The shape of the instance to use for building the image."
  default     = "VM.Standard.E4.Flex"
}

variable "subnet_ocid" {
  type        = string
  description = "The OCID of the subnet to launch the instance in."
}

variable "image_name_prefix" {
  type        = string
  description = "Prefix for the name of the custom image."
  default     = "ubuntu-base-image"
}

variable "region" {
  type        = string
  description = "The OCI region where the image will be built."
}
