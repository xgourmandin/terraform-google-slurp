locals {
  confs = { for c in var.api_configurations : c.name => c }
}


