output "slurp_server_endpoint" {
  value = google_cloud_run_service.slurp_server.status.0.url
}

output "slurp_server_sa_email" {
  value = google_service_account.server_sa.email
}

output "slurp_dashboard_endpoint" {
  value = one(google_cloud_run_service.slurp_dashboard[*].status.0.url)
}

output "slurp_dashboard_sa_email" {
  value = length(var.dashboard_service_account) > 0 ? var.dashboard_service_account : google_service_account.dashboard_sa.email
}