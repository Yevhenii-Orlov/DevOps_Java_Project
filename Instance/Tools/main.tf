resource "google_compute_instance" "petclinic" {
  name         = "petclinic"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20210604"
    }
  }

  network_interface {
    network = var.network

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOF
    #!bin/bash
    sudo apt update
    sudo apt install openjdk-11-jdk -y
    sudo apt install maven -y
    sudo ufw enable -y
    sudo ufw allow from any to any port 8080 proto tcp -y
    sudo ufw allow from any to any port 80 proto tcp -y
    sudo ufw allow from any to any port 22 proto tcp -y
    sudo apt-get update
    EOF

  scheduling {
    automatic_restart = true
  }

}
