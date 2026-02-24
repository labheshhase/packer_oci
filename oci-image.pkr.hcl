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
  shape               = var.instance_shape

  shape_config {
    ocpus         = 1
    memory_in_gbs = 8
  }

  base_image_filter {
    operating_system         = "Canonical Ubuntu"
    operating_system_version = "22.04"
  }

  image_name    = "${var.image_name_prefix}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  instance_name = "packer-build-instance-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  ssh_username  = "ubuntu"

  create_vnic_details {
    assign_public_ip = true
  }
}

build {
  name    = "oci-ubuntu-image"
  sources = ["source.oracle-oci.ubuntu"]

  provisioner "shell" {
    inline = ["sudo cloud-init status --wait"]
  }

  provisioner "shell" {
    script = "./setup.sh"
  }
}
