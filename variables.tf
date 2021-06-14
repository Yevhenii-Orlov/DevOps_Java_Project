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

variable "gke_zones" {
  description = "GKE Zones"
  type        = list(string)
  default     = ["us-west1-a,us-west1-b"]
}

variable "gke_cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "app-cluster"
}

variable "gke_network" {
  description = "GKE Network Name"
  type        = string
  default     = "default"
}

variable "gke_subnetwork" {
  description = "GKE subnetwork Name"
  type        = string
  default     = "us-west1"
}

variable "gke_service_account" {
  description = "DKE Service Account"
  type        = string
  default     = "devops-java-project@devops-java-project.iam.gserviceaccount.com"
}
