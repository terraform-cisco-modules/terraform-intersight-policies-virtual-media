<!-- BEGIN_TF_DOCS -->
# Virtual Media Policy Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

### main.tf
```hcl
module "vmedia_policy" {
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
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
```

### versions.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = var.secretkey
}
```
<!-- END_TF_DOCS -->