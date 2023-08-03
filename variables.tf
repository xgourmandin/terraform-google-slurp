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

variable "api_configurations" {
  type = list(object({
    name   = string
    url    = string
    method = string
    auth = optional(object({
      type        = string
      in_header   = bool
      token_env   = string
      token_param = string
    }))
    pagination = optional(object({
      type           = string
      page_param     = string
      limit_param    = string
      page_size      = number
      next_link_path = string
    }))
    data = object({
      type = string
      root = string
    })
    additional_headers     = optional(map(string))
    additional_queryparams = optional(map(string))
    output = optional(object({
      type       = string
      filename   = optional(string)
      bucket     = optional(string)
      project    = optional(string)
      dataset    = optional(string)
      table      = optional(string)
      autodetect = optional(bool)
    }))
  }))

  default = []

  description = <<EOT
    api_configurations = {
      name: The unique name of this API configuration
      url: The API endpoint
      method: Http method (GET or POST)
      auth = {
        type        : The Authentication type (API_KEY supported)
        in_header   : Whether to put the credential in request header or in query param (if false)
        token_env   : The token value environment variable
        token_param : The name of the authentication parameter to add to the request
      }
      token_scopes : "List of scopes affected by this service account impersonation"
      token_lifetime : "Time the token will be active"
    }
  EOT

  validation {
    condition = alltrue([
      for conf in var.api_configurations : (
        conf.method == "GET" || conf.method == "POST"
      )
    ])
    error_message = "API method shall be one of GET or POST"
  }
}
