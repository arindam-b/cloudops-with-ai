resource "google_cloud_run_v2_service" "cloudrun" {
  name                = var.clourun_servicename
  location            = var.region
  deletion_protection = false
  launch_stage        = "GA"

  template {

    service_account = format("%s@%s.iam.gserviceaccount.com", var.sa_name, var.project_id)

    execution_environment = "EXECUTION_ENVIRONMENT_GEN2"

    containers {
      image = var.image_url

      env {
        name  = "project_id"
        value = var.project_id
      }

      env {
        name  = "location"
        value = var.region
      }

      env {
        name  = "gcs_bucket"
        value = var.gcs_bucket
      }

      env {
        name  = "model_id"
        value = var.llm_model
      }

      env {
        name  = "org_name"
        value = var.org_name
      }

      env {
        name  = "local_directory"
        value = var.local_directory
      }

      env {
        name  = "user"
        value = var.user
      }

      env {
        name = "PAT"
        value_source {
          secret_key_ref {
            secret  = var.secret_id
            version = "latest"
          }
        }
      }

      resources {
        startup_cpu_boost = true
        limits = {
          cpu    = "1"
          memory = "1024Mi"
        }
      }
    }

  }

  depends_on = [resource.google_project_service.run]
}
