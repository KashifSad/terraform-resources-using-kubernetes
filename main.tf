provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to your kubeconfig file
}
resource "kubernetes_pod" "nginx_pod" {
  metadata {
    name = "nginx"
    labels = {
      app = "nginx"
    }
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "nginx"

      port {
        container_port = 80
      }
    }
  }
}
resource "kubernetes_service" "nginx_service" {
  metadata {
    name = "nginx-service"
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"  # Exposes the service on a NodePort
  }
}

