## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.64, < 7 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.64, < 7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.64, < 7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_v2_service.cloudrun](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service) | resource |
| [google_project_iam_member.secretmanager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.storage_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.vertex_ai_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.run](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.service_accounts](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clourun_servicename"></a> [clourun\_servicename](#input\_clourun\_servicename) | Cloud run description | `string` | `"Cloud run service for GCP Hackathon"` | no |
| <a name="input_gcs_bucket"></a> [gcs\_bucket](#input\_gcs\_bucket) | GCS bucket name | `string` | n/a | yes |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | Docker image URL for the Cloud Run service | `string` | n/a | yes |
| <a name="input_llm_model"></a> [llm\_model](#input\_llm\_model) | LLM model name | `string` | n/a | yes |
| <a name="input_local_directory"></a> [local\_directory](#input\_local\_directory) | Local directory in cloud run for file processing | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Github org name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project id | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"europe-west1"` | no |
| <a name="input_sa_name"></a> [sa\_name](#input\_sa\_name) | service account name | `string` | n/a | yes |
| <a name="input_secret_id"></a> [secret\_id](#input\_secret\_id) | Secret ID for DB password | `string` | n/a | yes |
| <a name="input_user"></a> [user](#input\_user) | github user | `string` | n/a | yes |

## Outputs

No outputs.
