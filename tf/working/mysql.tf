resource "kubernetes_service" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.blackdice.metadata[0].name
  }

  spec {
    ports = [
      {
        name           = "mysql"
        port           = 3306
        target_port     = 3306
        protocol       = "TCP"
      }
    ]

    selector = {
      app = "mysql"
    }
  }
}

resource "kubernetes_deployment" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.blackdice.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      matchLabels = {
        app = "mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }

      spec {
        container {
          name  = "mysql"
          image = "mysql:8.0"
          env = [
            {
              name = "MYSQL_ROOT_PASSWORD"
              value = "your-mysql-password"
            }
          ]
        }
      }
    }
  }
}