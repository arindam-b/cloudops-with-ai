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
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 4.64, < 7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_project_service_identity.pubsub_agent](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google_cloud_run_v2_service.cesar-cloudrun](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service) | resource |
| [google_cloud_run_v2_service_iam_binding.binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service_iam_binding) | resource |
| [google_project_iam_binding.project_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_member.secretmanager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.vertex_ai_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.run](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_pubsub_subscription.subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.service_accounts](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_pubsub_topic.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/pubsub_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudrun_service"></a> [cloudrun\_service](#input\_cloudrun\_service) | The name of the Cloud Run service | `string` | `"genai-incident-troubleshooting-cloudrun-service"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The deployment environment (e.g., dev, prod) | `string` | `"dev"` | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | docker image url | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix for resource names | `string` | `"my-prefix"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project ID | `string` | `"my-gcp-project"` | no |
| <a name="input_region"></a> [region](#input\_region) | The GCP region | `string` | `"us-central1"` | no |
| <a name="input_sa_name"></a> [sa\_name](#input\_sa\_name) | The Service Account for Cloud run service | `string` | `"genai-monitoring-svc"` | no |
| <a name="input_tavily_api_key"></a> [tavily\_api\_key](#input\_tavily\_api\_key) | The API key for Tavily | `string` | `""` | no |
| <a name="input_webhook_url"></a> [webhook\_url](#input\_webhook\_url) | The webhook URL for MS Teams notifications | `string` | `"https://example.com/webhook"` | no |

## Outputs

No outputs.
