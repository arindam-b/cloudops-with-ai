data "google_pubsub_topic" "default" {
  name = "notification-topic"
}

resource "google_cloud_run_v2_service" "cesar-cloudrun" {
  name                = format("%s-%s-%s", var.prefix, var.environment, var.cloudrun_service)
  location            = var.region
  deletion_protection = false
  launch_stage        = "GA"

  template {

    service_account = format("%s@%s.iam.gserviceaccount.com", var.sa_name, var.project_id)

    execution_environment = "EXECUTION_ENVIRONMENT_GEN2"

    containers {
      image = var.image_url

      env {
          name = "environment"
          value = var.environment
        }
        env {
          name = "MSTEAMS_WEBHOOK_URL"
          value = var.webhook_url
        }
        env {
          name = "PROJECT_ID"
          value = var.project_id
        }
        env {
          name = "REGION"
          value = var.region
        }
        env {
          name = "TAVILY_API_KEY"
          value = "tvly-"
        }
        env {
          name = "CUSTOM_POLICY_NAME_PREFIX"
          value = "my-alert-policy"
        }

      resources {
        startup_cpu_boost = true
      }
    }
  }

  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  depends_on = [resource.google_project_service.run]
}

# Create or select a service account to represent
# the Pub/Sub subscription identity.
resource "google_service_account" "sa" {
  account_id   = "pubsub-invoker"
  display_name = "Cesar Monitoring - Cloud Run Pub/Sub Invoker"
}

# Give the invoker service account permission to 
# invoke the cloud run service.
resource "google_cloud_run_v2_service_iam_binding" "binding" {
  name     = google_cloud_run_v2_service.cesar-cloudrun.name
  location = var.region
  role     = "roles/run.invoker"
  members  = ["serviceAccount:${google_service_account.sa.email}"]
}

# Allow Pub/Sub to create authentication tokens in the project.
resource "google_project_service_identity" "pubsub_agent" {
  provider = google-beta
  project  = var.project_id
  service  = "pubsub.googleapis.com"
}

resource "google_project_iam_binding" "project_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${google_project_service_identity.pubsub_agent.email}"]
}

# Create a Pub/Sub subscription with the service account.
resource "google_pubsub_subscription" "subscription" {
  name  = format("%s-%s-monitoring-notify", var.prefix, var.environment)
  topic = data.google_pubsub_topic.default.name
  push_config {
    push_endpoint = google_cloud_run_v2_service.cesar-cloudrun.urls.0
                    
    oidc_token {
      service_account_email = google_service_account.sa.email
    }
    attributes = {
      x-goog-version = "v1"
    }
  }
  depends_on = [google_cloud_run_v2_service.cesar-cloudrun]
}