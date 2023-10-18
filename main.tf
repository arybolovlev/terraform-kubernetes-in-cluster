terraform {
  # backend "kubernetes" {
  #   secret_suffix     = "terraform-state"
  #   in_cluster_config = true
  # }
}

provider "kubernetes" {}

resource "kubernetes_namespace_v1" "this" {
  metadata {
    name = "this"
  }
}

resource "kubernetes_pod_v1" "this" {
  metadata {
    name      = "this"
  }
  spec {
    container {
      name    = "this"
      image   = "busybox"
      command = ["sleep", "infinity"]
    }
  }
}
