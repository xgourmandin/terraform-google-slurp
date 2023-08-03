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
