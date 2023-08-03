variable "gcp_project_id" {
  type        = string
  description = "The project ID in which Slurp is deployed"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region in which Slurp is deployed"
  default     = "europe-west1"
}

variable "appengine_region" {
  type        = string
  description = "The GCP region in which Firestore will be located (must be a region where App Engine is available)"
  default     = "europe-west3"
}

variable "enable_dashboard" {
  type        = bool
  description = "Whether to deploy the Dashboard UI or not (it's not mandatory)"
  default     = false
}

variable "expose_dashboard" {
  type        = bool
  description = "Expose the Slurp dashboard publicly"
  default     = false
}

variable "dashboard_service_account" {
  type        = string
  description = "Optional service account email to run slurp dashboard with. Must have the run.invoker permission at least."
  default     = ""
}
