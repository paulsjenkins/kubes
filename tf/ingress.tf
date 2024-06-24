resource "kubernetes_ingress_v1" "api" {
  metadata {
    name      = "api"
    namespace = kubernetes_namespace.blackdice.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" = "gce"
    }
  }

  spec {
    rule {
      host = "api.blackdice.ai"
      http {
        path {
          path = "/"
          path_type = "ImplementationSpecific" // Add path_type here
          backend {
            service {
              name = "api"
              port {
                number = 3000
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "mqtt" {
  metadata {
    name      = "mqtt"
    namespace = kubernetes_namespace.blackdice.metadata[0].name
  }

  spec {
    rule {
      host = "mqtt.blackdice.ai" // No tls block for plain MQTT
      http {
        path {
          path      = "/"
          path_type = "ImplementationSpecific"
          backend {
            service {
              name = "mosquitto"
              port {
                number = 1883
              }
            }
          }
        }
      }
    }
  }
}