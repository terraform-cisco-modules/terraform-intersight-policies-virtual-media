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
