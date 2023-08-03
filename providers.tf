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

locals {
  slurp_server_url = "https://slurp-server-${var.cloud_run_namespace}.a.run.app"
}

data "google_service_account_id_token" "oidc" {
  target_audience        = local.slurp_server_url
  target_service_account = google_service_account.server_sa.email
  include_email          = true
  delegates              = []
}

provider "restapi" {
  uri     = local.slurp_server_url
  headers = {
    Authorization = "Bearer ${data.google_service_account_id_token.oidc.id_token}"
  }
}