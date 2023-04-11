output "slurp_server_endpoint" {
  value = google_cloud_run_service.slurp_server.status.0.url
}

output "slurp_dashboard_endpoint" {
  value = one(google_cloud_run_service.slurp_dashboard[*].status.0.url)
}