module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google"
  project_id             = var.gcp_project
  name                   = var.gke_cluster_name
  region                 = var.gcp_region
  network                = var.gke_network
  subnetwork             = var.gke_subnetwork
  ip_range_pods          = "us-west1-01-gke-01-pods"
  ip_range_services      = "us-west1-01-gke-01-services"
  create_service_account = false
  service_account        = var.gke_service_account
}
resource "kubernetes_pod" "nginx-example" {
  metadata {
    name = "nginx-example"

    labels = {
      maintained_by = "terraform"
      app           = "nginx-example"
    }
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "nginx-example"
    }
  }

  depends_on = [module.gke]
}

resource "kubernetes_service" "nginx-example" {
  metadata {
    name = "terraform-example"
  }

  spec {
    selector = {
      app = kubernetes_pod.nginx-example.metadata[0].labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }

  depends_on = [module.gke]
}
