resource "google_service_account" "server_sa" {
  account_id   = "slurp-server-sa"
  display_name = "Slurp Server SA"
}

resource "google_cloud_run_service" "slurp_server" {
  location = var.gcp_region
  name     = "slurp-server"

  template {
    spec {
      service_account_name = google_service_account.server_sa.email
      containers {
        image = "gofx/slurp-server"
        env {
          name  = "STORAGE_TYPE"
          value = "firestore"
        }
        env {
          name  = "PROJECT_ID"
          value = var.gcp_project_id
        }
        ports {
          name           = "http1"
          container_port = 3000
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_project_service.firestore_api]
}

resource "google_cloud_run_service_iam_member" "server_sa_binding" {
  location = google_cloud_run_service.slurp_server.location
  member   = "serviceAccount:${google_service_account.server_sa.email}"
  role     = "roles/run.invoker"
  service  = google_cloud_run_service.slurp_server.name
}

resource "google_project_iam_member" "slurp_server_firestore_binding" {
  project = var.gcp_project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.server_sa.email}"
}

resource "google_service_account" "dashboard_sa" {
  count        = var.dashboard_service_account == "" ? 1 : 0
  account_id   = "slurp-dashboard-sa"
  display_name = "Slurp Dashboard SA"
}

resource "google_project_iam_member" "dashboard_invoker_binding" {
  count   = var.dashboard_service_account == "" ? 1 : 0
  project = var.gcp_project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.dashboard_sa[count.index].email}"
}

resource "google_cloud_run_service" "slurp_dashboard" {
  count    = var.enable_dashboard ? 1 : 0
  location = var.gcp_region
  name     = "slurp-dashboard"

  template {
    spec {
      service_account_name = var.dashboard_service_account == "" ? google_service_account.dashboard_sa[count.index].email : var.dashboard_service_account
      containers {
        image = "gofx/slurp-dashboard"
        env {
          name  = "SLURP_SERVER_URL"
          value = google_cloud_run_service.slurp_server.status.0.url
        }
        env {
          name  = "DEPLOY_TARGET"
          value = "cloudrun"
        }
        ports {
          name           = "http1"
          container_port = 3000
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

}

resource "google_cloud_run_service_iam_binding" "default" {
  count    = var.enable_dashboard && var.expose_dashboard ? 1 : 0
  location = google_cloud_run_service.slurp_dashboard[count.index].location
  service  = google_cloud_run_service.slurp_dashboard[count.index].name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}

