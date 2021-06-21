terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.72.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_credentials)
  project     = var.gcp_project
  region      = var.gcp_region
}
