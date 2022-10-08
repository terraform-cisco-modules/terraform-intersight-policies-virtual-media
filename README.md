<!-- BEGIN_TF_DOCS -->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)
[![Tests](https://github.com/terraform-cisco-modules/terraform-intersight-policies-virtual-media/actions/workflows/terratest.yml/badge.svg)](https://github.com/terraform-cisco-modules/terraform-intersight-policies-virtual-media/actions/workflows/terratest.yml)

# Terraform Intersight Policies - Virtual Media
Manages Intersight Virtual Media Policies

Location in GUI:
`Policies` » `Create Policy` » `Virtual Media`

## Easy IMM

[*Easy IMM - Comprehensive Example*](https://github.com/terraform-cisco-modules/easy-imm-comprehensive-example) - A comprehensive example for policies, pools, and profiles.

## Example

### main.tf
```hcl
module "virtual_media" {
  source  = "terraform-cisco-modules/policies-virtual-media/intersight"
  version = ">= 1.0.1"

  add_virtual_media = [
    {
      device_type   = "cdd"
      file_location = "http://198.18.1.10/mount.iso"
      mount_options = "noauto"
      name          = "http_server"
      protocol      = "http"
    }
  ]
  description                     = "default Virtual Media Policy."
  enable_virtual_media            = true
  enable_low_power_usb            = true
  enable_virtual_media_encryption = true
  name                            = "default"
  organization                    = "default"
}
```

### provider.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = fileexists(var.secretkeyfile) ? file(var.secretkeyfile) : var.secretkey
}
```

### variables.tf
```hcl
variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  default     = ""
  description = "Intersight Secret Key Content."
  sensitive   = true
  type        = string
}

variable "secretkeyfile" {
  default     = "blah.txt"
  description = "Intersight Secret Key File Location."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with the value of [your-api-key]
- Add variable secretkey with the value of [your-secret-file-content]

### Linux and Windows
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkeyfile="<secret-key-file-location>"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_virtual_media"></a> [add\_virtual\_media](#input\_add\_virtual\_media) | * authentication\_protocol: (optional) - Type of Authentication protocol when CIFS is used for communication with the remote server.<br>  - none: (default) - No authentication is used.<br>  - ntlm - NT LAN Manager (NTLM) security protocol. Use this option only with Windows 2008 R2 and Windows 2012 R2.<br>  - ntlmi - NTLMi security protocol. Use this option only when you enable Digital Signing in the CIFS Windows server.<br>  - ntlmv2 - NTLMv2 security protocol. Use this option only with Samba Linux.<br>  - ntlmv2i - NTLMv2i security protocol. Use this option only with Samba Linux.<br>  - ntlmssp - NT LAN Manager Security Support Provider (NTLMSSP) protocol. Use this option only with Windows 2008 R2 and Windows 2012 R2.<br>  - ntlmsspi - NTLMSSPi protocol. Use this option only when you enable Digital Signing in the CIFS Windows server.<br>* device\_type: (optional) - Type of remote Virtual Media device.<br>  - cdd: (default) - Uses compact disc drive as the virtual media mount device.<br>  - hdd - Uses hard disk drive as the virtual media mount device.<br>* file\_location: (required) - The remote file location path for the virtual media mapping. Accepted formats are:<br>  - HDD for CIFS/NFS: hostname-or-IP/filePath/fileName.img<br>  - CDD for CIFS/NFS: hostname-or-IP/filePath/fileName.iso<br>  - HDD for HTTP/S: http[s]://hostname-or-IP/filePath/fileName.img<br>  - CDD for HTTP/S: http[s]://hostname-or-IP/filePath/fileName.iso<br>* mount\_options: (optional) - Mount options for the Virtual Media mapping. The field can be left blank or filled in a comma separated list with the following options.<br>  - For NFS, supported options are:<br>    * ro<br>    * rw<br>    * nolock<br>    * noexec<br>    * soft<br>    * port=VALUE<br>    * timeo=VALUE<br>    * retry=VALUE<br>  - For CIFS, supported options are:<br>    * soft<br>    * nounix<br>    * noserverino<br>    * guest<br>    Note: For CIFS version less than 3.0, vers=VALUE is mandatory. e.g. vers=2.0<br>  - For HTTP/HTTPS, the only supported option is:<br>    * noauto<br>* name: (required) - Name of the Virtual Media Mount<br>* password: (optional) - A Number used in the loop to point to the variable "vmedia\_password\_[1-5]".  So 1 would be vmedia\_password\_1.  Sensitive Values are not supported in a loop<br>* protocol: (optional) - Protocol to use to communicate with the remote server.<br>  - nfs: (default) - NFS protocol for vmedia mount.<br>  - cifs - CIFS protocol for vmedia mount.<br>  - http - HTTP protocol for vmedia mount.<br>  - https - HTTPS protocol for vmedia mount.<br>* username: (optional) - Username to log in to the remote server, if authentication is enabled. | <pre>list(object(<br>    {<br>      authentication_protocol = optional(string, "none")<br>      device_type             = optional(string, "cdd")<br>      file_location           = string<br>      mount_options           = optional(string, "")<br>      name                    = string<br>      password                = optional(number, 0)<br>      protocol                = optional(string, "nfs")<br>      username                = optional(string, "")<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy. | `string` | `""` | no |
| <a name="input_enable_low_power_usb"></a> [enable\_low\_power\_usb](#input\_enable\_low\_power\_usb) | If enabled, the virtual drives appear on the boot selection menu after mapping the image and rebooting the host. | `bool` | `false` | no |
| <a name="input_enable_virtual_media"></a> [enable\_virtual\_media](#input\_enable\_virtual\_media) | Flag to Enable or Disable the Policy. | `bool` | `true` | no |
| <a name="input_enable_virtual_media_encryption"></a> [enable\_virtual\_media\_encryption](#input\_enable\_virtual\_media\_encryption) | If enabled, allows encryption of all Virtual Media communications. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"default"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | List of Profiles to Assign to the Policy.<br>  * name - Name of the Profile to Assign.<br>  * object\_type - Object Type to Assign in the Profile Configuration.<br>    - server.Profile - For UCS Server Profiles.<br>    - server.ProfileTemplate - For UCS Server Profile Templates. | <pre>list(object(<br>    {<br>      moid        = string<br>      object_type = optional(string, "server.Profile")<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
| <a name="input_vmedia_password_1"></a> [vmedia\_password\_1](#input\_vmedia\_password\_1) | Password for vMedia | `string` | `""` | no |
| <a name="input_vmedia_password_2"></a> [vmedia\_password\_2](#input\_vmedia\_password\_2) | Password for vMedia | `string` | `""` | no |
| <a name="input_vmedia_password_3"></a> [vmedia\_password\_3](#input\_vmedia\_password\_3) | Password for vMedia | `string` | `""` | no |
| <a name="input_vmedia_password_4"></a> [vmedia\_password\_4](#input\_vmedia\_password\_4) | Password for vMedia | `string` | `""` | no |
| <a name="input_vmedia_password_5"></a> [vmedia\_password\_5](#input\_vmedia\_password\_5) | Password for vMedia | `string` | `""` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | Virtual Media Policy Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_vmedia_policy.virtual_media](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/vmedia_policy) | resource |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
| [intersight_server_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile) | data source |
| [intersight_server_profile_template.templates](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile_template) | data source |
<!-- END_TF_DOCS -->