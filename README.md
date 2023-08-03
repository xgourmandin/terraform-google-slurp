# terraform-google-slurp
A Terraform module to deploy Slurp server and dashboard on GCP Cloud Run

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | 1.18.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.76.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service.slurp_dashboard](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service.slurp_server](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_binding.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_binding) | resource |
| [google_cloud_run_service_iam_member.server_sa_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |
| [google_project_iam_member.dashboard_invoker_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.slurp_server_firestore_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.app_engine_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.firestore_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.dashboard_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.server_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_id_token.oidc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account_id_token) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appengine_region"></a> [appengine\_region](#input\_appengine\_region) | The GCP region in which Firestore will be located (must be a region where App Engine is available) | `string` | `"europe-west3"` | no |
| <a name="input_dashboard_service_account"></a> [dashboard\_service\_account](#input\_dashboard\_service\_account) | Optional service account email to run slurp dashboard with. Must have the run.invoker permission at least. | `string` | `""` | no |
| <a name="input_enable_dashboard"></a> [enable\_dashboard](#input\_enable\_dashboard) | Whether to deploy the Dashboard UI or not (it's not mandatory) | `bool` | `false` | no |
| <a name="input_expose_dashboard"></a> [expose\_dashboard](#input\_expose\_dashboard) | Expose the Slurp dashboard publicly | `bool` | `false` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The project ID in which Slurp is deployed | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The GCP region in which Slurp is deployed | `string` | `"europe-west1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_slurp_dashboard_endpoint"></a> [slurp\_dashboard\_endpoint](#output\_slurp\_dashboard\_endpoint) | Slurp Dashboard Cloud Run URL |
| <a name="output_slurp_dashboard_sa_email"></a> [slurp\_dashboard\_sa\_email](#output\_slurp\_dashboard\_sa\_email) | Service account email used to run Slurp Dashboard Cloud Run |
| <a name="output_slurp_server_endpoint"></a> [slurp\_server\_endpoint](#output\_slurp\_server\_endpoint) | Slurp server Cloud Run URL |
| <a name="output_slurp_server_sa_email"></a> [slurp\_server\_sa\_email](#output\_slurp\_server\_sa\_email) | Service account email used to run Slurp Server Cloud Run |
<!-- END_TF_DOCS -->