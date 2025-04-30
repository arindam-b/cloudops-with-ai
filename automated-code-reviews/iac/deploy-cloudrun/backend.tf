terraform {
  backend "gcs" {
    bucket = "prj-p-eden-infra-state"
    prefix = "terraform/cloudrun-codereview"
  }
}
