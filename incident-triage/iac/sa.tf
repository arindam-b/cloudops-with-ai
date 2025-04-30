# Service account created for cloud run service to run
resource "google_service_account" "service_accounts" {
  account_id   = var.sa_name
  display_name = format("Service Account for cloud run incident troubleshooting notification api")
}


resource "google_project_iam_member" "vertex_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.service_accounts.email}"
}

resource "google_project_iam_member" "secretmanager" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.service_accounts.email}"
}
