resource "kubernetes_service" "api" {
  metadata {
    name      = "api"
    namespace = kubernetes_namespace.blackdice.metadata[0].name
  }

  spec {
    ports = [
      {
        name           = "api"
        port           = 3000
        target_port     = 3000
        protocol       = "TCP"
      }
    ]

    selector = {
      app = "nodejs-app"
    }
  }
}

resource "kubernetes_deployment" "nodejs-app" {
  metadata {
    name      = "nodejs-app"
    namespace = kubernetes_namespace.blackdice.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      matchLabels = {
        app = "nodejs-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "nodejs-app"
        }
      }

      spec {
        container {
          name  = "nodejs-app"
          image = "your-ghcr-repo/your-image-name:16.0"
          env = [
            {
              name = "REDIS_HOST"
              value = "redis"
            },
            {
              name = "REDIS_PORT"
              value = "6379"
            }
          ]
        }
      }
    }
  }
}