# Input variable definitions

variable "gcp_credentials" {
  type    = string
  default = "/home/yevhenii/Documents/DevOps/GCP_Terraform_Credentials/gcp-credentials.json"
}

variable "gcp_project" {
  type    = string
  default = "devops-java-project"
}

variable "gcp_region" {
  type    = string
  default = "us-west1"
}

variable "gcp_zone" {
  type    = string
  default = "us-west1-a"
}

variable "gke_zones" {
  type    = list(string)
  default = ["us-west1-a,us-west1-b"]
}

variable "gke_cluster_name" {
  type    = string
  default = "app-cluster"
}

variable "gke_network" {
  type    = string
  default = "default"
}

variable "gke_subnetwork" {
  type    = string
  default = "us-west1"
}

variable "gke_service_account" {
  type    = string
  default = "devops-java-project@devops-java-project.iam.gserviceaccount.com"
}

variable "network" {
  type    = string
  default = "devops-java-project-vpc"
}

variable "subnetwork" {
  type    = string
  default = "devops-java-project-subnet"
}
