resource "google_project_service" "app_engine_api" {
  service                    = "appengine.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
}

resource "google_project_service" "firestore_api" {
  service                    = "firestore.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = true
}

resource "google_firestore_database" "database" {
  project                     = var.gcp_project_id
  name                        = "(default)"
  location_id                 = var.appengine_region
  type                        = "FIRESTORE_NATIVE"
  concurrency_mode            = "OPTIMISTIC"
  app_engine_integration_mode = "DISABLED"

  depends_on = [google_project_service.firestore_api]
}
