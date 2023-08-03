terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.1"
    }
  }
  backend "gcs" {
    bucket = "slurp-terraform-state"
    prefix = "slurp/state"
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}
