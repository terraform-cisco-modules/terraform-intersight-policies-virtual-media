module "main" {
  source = "../.."

  add_virtual_media = [
    {
      device_type   = "cdd"
      file_location = "http://198.18.0.80/mount.iso"
      mount_options = "noauto"
      name          = "http_server"
      protocol      = "http"
    }
  ]
  description                     = "${var.name} Virtual Media Policy."
  enable_virtual_media            = true
  enable_low_power_usb            = true
  enable_virtual_media_encryption = true
  name                            = var.name
  organization                    = "terratest"
}
