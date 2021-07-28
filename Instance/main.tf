resource "google_service_account" "default" {
  account_id   = var.project
  display_name = "Service Account"
}

# VPC Network
resource "google_compute_network" "vpc" {
  name                    = var.network
  auto_create_subnetworks = true
}

# firewall
resource "google_compute_firewall" "firewall" {
  name    = "instance-firewall"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080", "80", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_instance" "jenkins" {
  name         = "devtools"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20210604"
    }
  }

  network_interface {
    network = google_compute_network.vpc.name

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOF
    #!bin/bash
    sudo apt update
    sudo apt install openjdk-11-jdk -y
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install jenkins -y
    sudo ufw enable -y
    sudo ufw allow from any to any port 8080 proto tcp -y
    sudo ufw allow from any to any port 80 proto tcp -y
    sudo ufw allow from any to any port 22 proto tcp -y
    sudo apt-get update
    EOF

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

  scheduling {
    automatic_restart = true
  }

}
