# packer_oci

# Packer OCI Image Builder

## Overview
This repository contains the Infrastructure as Code (IaC) required to automate the creation of custom Compute Images on Oracle Cloud Infrastructure (OCI). It utilizes **HashiCorp Packer** for image generation and **GitHub Actions** for CI/CD automation.

## Architecture

The workflow follows a secure, automated process to provision a temporary instance, configure it, and capture it as a reusable image.

<img width="1118" height="1128" alt="image" src="https://github.com/user-attachments/assets/e42d9e38-f200-4920-92ca-324ce2f4de8d" />


## Prerequisites

### 1. OCI Account & Permissions
Ensure the OCI user associated with this pipeline has permissions to:
- Manage `instance-family` (Launch/Terminate instances).
- Manage `volume-family` (Create boot volumes).
- Manage `image-family` (Create/Delete custom images).
- Use `virtual-network-family` (Access VCN/Subnets).

### 2. API Signing Keys
1. Log in to the OCI Console.
2. Navigate to **Identity & Security** > **Users** > Select User > **API Keys**.
3. Add an API Key and download the Private Key (`.pem` file).
4. Note the `Fingerprint`, `User OCID`, and `Tenancy OCID`.

## Setup

### GitHub Secrets Configuration
To enable the pipeline, navigate to your GitHub Repository **Settings** > **Secrets and variables** > **Actions** and add the following secrets:

| Secret Name | Description |
|-------------|-------------|
| `OCI_USER_OCID` | The OCID of the user performing the build. |
| `OCI_TENANCY_OCID` | The OCID of your OCI Tenancy. |
| `OCI_FINGERPRINT` | The fingerprint of the API Key. |
| `OCI_API_PRIVATE_KEY` | The **content** of the private key `.pem` file. |
| `OCI_REGION` | The target OCI region (e.g., `us-ashburn-1`). |
| `OCI_AVAILABILITY_DOMAIN` | The AD where the builder instance runs (e.g., `Uocm:US-ASHBURN-AD-1`). |
| `OCI_COMPARTMENT_OCID` | The Compartment OCID for resources and images. |
| `OCI_SUBNET_OCID` | The Subnet OCID (must allow outbound internet access). |
| `OCI_OCPUS` | Number of OCPUs for the builder instance (if using Flex shapes). |

## Usage

### Automated Build (CI/CD)
The pipeline is defined in `.github/workflows/packer-build.yml`. It triggers automatically on:
1. **Push to Main**: Any commit to the `main` branch.
2. **Manual Dispatch**: Go to the **Actions** tab, select **Packer OCI Image Build**, and click **Run workflow**.

### Local Development
To run Packer locally on your machine:

1. **Install Packer**: Download Link
2. **Create Variables File**: Create a file named `local.pkrvars.hcl` (do not commit this file):
   ```hcl
   availability_domain = "YOUR_AD"
   compartment_ocid    = "YOUR_COMPARTMENT_OCID"
   subnet_ocid         = "YOUR_SUBNET_OCID"
   region              = "us-ashburn-1"
   ```
3. **Run Build**:
   ```bash
   packer init .
   packer validate -var-file="local.pkrvars.hcl" .
   packer build -var-file="local.pkrvars.hcl" .
   ```

## License
MIT
