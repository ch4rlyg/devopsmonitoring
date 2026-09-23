resource "kubernetes_namespace" "webapp" {
  metadata {
    name = var.namespace_name
  }

  depends_on = [azurerm_kubernetes_cluster.aks_01]
}

resource "kubernetes_deployment" "webapp" {
  # No esperar a que los pods queden Ready: la imagen la sube el workflow de
  # GitHub Actions por separado (puede no existir aun en el primer apply).
  # Sin esto, Terraform falla el apply completo -y deja el Service sin crear-
  # cada vez que la imagen todavia no esta en el ACR.
  wait_for_rollout = false

  metadata {
    name      = "webapp"
    namespace = kubernetes_namespace.webapp.metadata.0.name
    labels = {
      app = "webapp"
    }
  }

  spec {
    replicas = var.webapp_replicas

    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        container {
          name              = "webapp"
          image             = "${azurerm_container_registry.acr_01.login_server}/${var.webapp_image}"
          image_pull_policy = "Always"

          port {
            container_port = 80
          }
        }
      }
    }
  }

  depends_on = [kubernetes_namespace.webapp, azurerm_role_assignment.aks_acr_pull]
}

resource "kubernetes_service" "webapp" {
  metadata {
    name      = "webapp"
    namespace = kubernetes_namespace.webapp.metadata.0.name
  }

  spec {
    selector = {
      app = "webapp"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }

  depends_on = [kubernetes_deployment.webapp]
}
