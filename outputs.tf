#____________________________________________________________
#
# Collect the moid of the Virtual Media Policy as an Output
#____________________________________________________________

output "moid" {
  description = "Virtual Media Policy Managed Object ID (moid)."
  value       = intersight_vmedia_policy.virtual_media.moid
}
