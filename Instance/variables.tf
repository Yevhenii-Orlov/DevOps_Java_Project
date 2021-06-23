# Input variable definitions

variable "credentials" {
  type    = string
  default = "/home/yevhenii/Documents/DevOps/GCP_Terraform_Credentials/gcp-credentials.json"
}

variable "project" {
  type    = string
  default = "devops-java-project"
}

variable "region" {
  type    = string
  default = "us-west1"
}

variable "zone" {
  type    = string
  default = "us-west1-a"
}

variable "network" {
  type    = string
  default = "devops-java-project-vpc"
}
