# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.gcp_project}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.gcp_project}-subnet"
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

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



/*module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google"
  project_id             = var.gcp_project
  name                   = var.gke_cluster_name
  region                 = var.gcp_region
  network                = "${var.gcp_project}-vpc"
  subnetwork             = "${var.gcp_project}-subnet"
  ip_range_pods          = "us-west1-01-gke-01-pods"
  ip_range_services      = "us-west1-01-gke-01-services"
  create_service_account = false
  service_account        = var.gke_service_account

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      node_locations     = "us-west1-b,us-west1-c"
      min_count          = 1
      max_count          = 2
      local_ssd_count    = 0
      disk_size_gb       = 10
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "${var.gcp_project}"
      preemptible        = false
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}*/
