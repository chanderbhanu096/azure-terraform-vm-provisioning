locals {
  adf_safe_project = lower(replace(var.project_name, "-", "_"))
}
