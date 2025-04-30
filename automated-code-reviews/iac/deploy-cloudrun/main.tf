module "cloudrun" {
  source                        = "../modules/cloudrun"
  project_id                    = var.project_id
  region                        = var.region
  clourun_servicename           = var.clourun_servicename
  image_url                     = var.image_url  
  gcs_bucket                    = var.gcs_bucket
  llm_model                     = var.llm_model
  secret_id                     = var.secret_id
  sa_name                       = var.sa_name
  org_name                      = var.org_name
  local_directory               = var.local_directory
  user                          = var.user
}
