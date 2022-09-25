#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  for_each = {
    for v in [var.organization] : v => v if length(
      regexall("[[:xdigit:]]{24}", var.organization)
    ) == 0
  }
  name = each.value
}

#____________________________________________________________
#
# Intersight UCS Server Profile(s) Data Source
# GUI Location: Profiles > UCS Server Profiles > {Name}
#____________________________________________________________

data "intersight_server_profile" "profiles" {
  for_each = { for v in var.profiles : v.name => v if v.object_type == "server.Profile" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight UCS Server Profile(s) Template Data Source
# GUI Location: Templates > UCS Server Profile Templates > {Name}
#__________________________________________________________________

data "intersight_server_profile_template" "templates" {
  for_each = { for v in var.profiles : v.name => v if v.object_type == "server.ProfileTemplate" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight Virtual Media Policy
# GUI Location: Policies > Create Policy > Virtual Media
#__________________________________________________________________

resource "intersight_vmedia_policy" "virtual_media" {
  depends_on = [
    data.intersight_server_profile.profiles,
    data.intersight_server_profile_template.templates
  ]
  description   = var.description != "" ? var.description : "${var.name} Virtual Media Policy."
  enabled       = var.enable_virtual_media
  encryption    = var.enable_virtual_media_encryption
  low_power_usb = var.enable_low_power_usb
  name          = var.name
  organization {
    moid = length(
      regexall("[[:xdigit:]]{24}", var.organization)
      ) > 0 ? var.organization : data.intersight_organization_organization.org_moid[
      var.organization].results[0
    ].moid
    object_type = "organization.Organization"
  }
  dynamic "mappings" {
    for_each = { for v in var.add_virtual_media : v.name => v }
    content {
      additional_properties   = ""
      authentication_protocol = mappings.value.authentication_protocol
      class_id                = "vmedia.Mapping"
      device_type             = mappings.value.device_type
      file_location           = mappings.value.file_location
      host_name               = ""
      is_password_set         = mappings.value.password != 0 ? true : false
      mount_options           = mappings.value.mount_options
      mount_protocol          = mappings.value.protocol
      object_type             = "vmedia.Mapping"
      password = length(
        regexall("1", mappings.value.password)) > 0 ? var.vmedia_password_1 : length(
        regexall("2", mappings.value.password)) > 0 ? var.vmedia_password_2 : length(
        regexall("3", mappings.value.password)) > 0 ? var.vmedia_password_3 : length(
        regexall("4", mappings.value.password)) > 0 ? var.vmedia_password_4 : length(
        regexall("5", mappings.value.password)
      ) > 0 ? var.vmedia_password_5 : ""
      remote_file = ""
      remote_path = ""
      username    = mappings.value.username
      volume_name = mappings.value.name
    }
  }
  dynamic "profiles" {
    for_each = { for v in var.profiles : v.name => v }
    content {
      moid = length(regexall("server.ProfileTemplate", profiles.value.object_type)
        ) > 0 ? data.intersight_server_profile_template.templates[profiles.value.name].results[0
      ].moid : data.intersight_server_profile.profiles[profiles.value.name].results[0].moid
      object_type = profiles.value.object_type
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
