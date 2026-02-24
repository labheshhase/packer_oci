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
  compartment_ocid    = var.compartment_ocid
  subnet_ocid         = var.subnet_ocid
  region              = var.region

  # FIX 1: Removed GPU filter — use standard Ubuntu 22.04 base image
  base_image_filter  {
    operating_system         = "Canonical Ubuntu"
    operating_system_version = "22.04"
    # No display_name_search = matches latest standard Ubuntu 22.04
  }

  # FIX 2: Add shape_config — required for all Flex shapes
  shape = var.instance_shape
  shape_config {
    ocpus         = 1
    memory_in_gbs = 8
  }

  image_name    = "${var.image_name_prefix}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  instance_name = "packer-build-instance-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  ssh_username  = "ubuntu"

  # Recommended: assign public IP so Packer can SSH in
  # If using private subnet + bastion, set this to false and add bastion config
  create_vnic_details {
    assign_public_ip = true
  }
}

build {
  name    = "oci-ubuntu-image"
  sources = ["source.oracle-oci.ubuntu"]

  # Wait for cloud-init before running scripts
  provisioner "shell" {
    inline = ["sudo cloud-init status --wait"]
  }

  # FIX 3: Correct script path — matches where setup.sh actually lives
  provisioner "shell" {
    script = "./setup.sh"
  }
}
