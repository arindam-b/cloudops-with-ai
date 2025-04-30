variable "webhook_url" {
  description = "The webhook URL for MS Teams notifications"
  type        = string
  default     = "https://example.com/webhook"
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "my-gcp-project"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "tavily_api_key" {
  description = "The API key for Tavily"
  type        = string
  default     = ""
}

variable "sa_name" {
  description = "The Service Account for Cloud run service"
  type        = string
  default     = "genai-monitoring-svc"
}

variable "image_url" {
    description = "docker image url"
    type        = string
    default     = ""
}

variable "prefix" {
  description = "The prefix for resource names"
  type        = string
  default     = "my-prefix"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "cloudrun_service" {
  description = "The name of the Cloud Run service"
  type        = string
  default     = "genai-incident-troubleshooting-cloudrun-service"
}
