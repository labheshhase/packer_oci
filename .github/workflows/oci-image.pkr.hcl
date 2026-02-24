packer {
  required_plugins {
    oracle = {
      source  = "github.com/hashicorp/oracle"
      version = "~> 1.1.2"
    }
  }
}

source "oracle-oci" "ubuntu" {
  availability_domain = var.availability_domain
  base_image_filter = {
    operating_system         = "Canonical Ubuntu"
    operating_system_version = "22.04"
    display_name_search      = "^Canonical-Ubuntu-22.04-.*-Gen2-GPU-.*"
  }
  compartment_ocid    = var.compartment_ocid
  shape               = var.instance_shape
  subnet_ocid         = var.subnet_ocid
  image_name          = "${var.image_name_prefix}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  instance_name       = "packer-build-instance-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  ssh_username        = "ubuntu"
  region              = var.region
}

build {
  name = "oci-ubuntu-image"
  sources = [
    "source.oracle-oci.ubuntu"
  ]
  provisioner "shell" {
    script = "./scripts/setup.sh"
  }
}
