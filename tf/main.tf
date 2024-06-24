provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Define the namespace for our workloads
resource "kubernetes_namespace" "blackdice" {
  metadata {
    name = "blackdice"
  }
}
