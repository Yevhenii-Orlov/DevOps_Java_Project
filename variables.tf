# Input variable definitions

variable "gcp_credentials" {
  description = "GCP Credentials"
  type        = string
  default     = "/home/yevhenii/Documents/DevOps/GCP_Terraform_Credentials/gcp-credentials.json"
}

variable "gcp_project" {
  description = "GCP Project Name"
  type        = string
  default     = "devops-java-project"
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-west1"
}

variable "gcp_zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-west1-a"
}
