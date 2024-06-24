resource "kubernetes_service" "mosquitto" {
  metadata {
    name      = "mosquitto"
    namespace = kubernetes_namespace.blackdice.metadata[0].name
  }

  spec {
    port {
      name        = "mosquitto"
      port        = 1883
      target_port = 1883
      protocol    = "TCP"
    }

    selector = {
      app = "mosquitto"
    }
  }
}

resource "kubernetes_deployment" "mosquitto" {
  metadata {
    name      = "mosquitto"
    namespace = kubernetes_namespace.blackdice.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mosquitto"
      }
    }

    template {
      metadata {
        labels = {
          app = "mosquitto"
        }
      }

      spec {
        container {
          name  = "mosquitto"
          image = "eclipse-mosquitto:1.6.12"
        }
      }
    }
  }
}
