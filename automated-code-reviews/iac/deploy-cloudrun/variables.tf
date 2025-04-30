variable "region" {
  type        = string
  default     = "europe-west1"
  description = "GCP region"
}

variable "project_id" {
  type        = string
  default     = ""
  description = "GCP project id"
}

variable "clourun_servicename" {
  type        = string
  default     = "Cloud run service for GCP Hackathon"
  description = "Cloud run description"
}

variable "image_url" {
  type        = string
  description = "Docker image URL for the Cloud Run service"
}

variable "gcs_bucket" {
  type        = string
  description = "GCS bucket name"
}

variable "llm_model" {
  type        = string
  description = "LLM model name"
}

variable "org_name" {
  type        = string
  description = "Github org name"
}

variable "local_directory" {
  type        = string
  description = "Local directory in cloud run for file processing"
}

variable "user" {
  type        = string
  description = "github user"
}

variable "secret_id" {
  type        = string
  description = "Secret ID for DB password"
}

variable "sa_name" {
  type        = string
  description = "service account name"
}
