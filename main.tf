provider "google" {
  credentials = file("/home/yevhenii/Documents/DevOps/GCP_Terraform_Credentials/gcp-credentials.json")
  project = "devops-java-project"
  region = "us-west1"
  zone = "us-west1-a"
}

resource "google_compute_instance" "vm_instance" {
  name = "devtools"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}
