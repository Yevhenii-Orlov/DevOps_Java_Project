
resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "primary" {
  name                     = "my-gke-cluster"
  location                 = var.gcp_region
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible     = true
    machine_type    = "e2-medium"
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "kubernetes_pod" "jenkins" {
  metadata {
    name = "jenkins-example"
  }

  spec {
    container {
      image = "jenkins/jenkins:lts"
      name  = "jenkins"

      port {
        name           = "http-port"
        container_port = 50000
      }

      liveness_probe {
        http_get {
          path = "/jenkins"
          port = 8080
        }
      }
    }
  }
}
