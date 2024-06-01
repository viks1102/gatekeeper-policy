resource "kubernetes_manifest" "constraint_template" {
  manifest = {
    apiVersion = "templates.gatekeeper.sh/v1"
    kind       = "ConstraintTemplate"
    metadata = {
      name = var.template_name
    }
    spec = {
      crd = {
        spec = {
          names = {
            kind = "K8sDenyRunAsRoot"
          }
        }
      }
      targets = [
        {
          target = "admission.k8s.gatekeeper.sh"
          rego   = var.rego_script
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "constraint" {
  manifest = {
    apiVersion = "constraints.gatekeeper.sh/v1beta1"
    kind       = "K8sDenyRunAsRoot"
    metadata = {
      name = var.constraint_name
    }
    spec = {
      match = {
        kinds = [
          {
            apiGroups = [""]
            kinds     = ["Pod"]
          }
        ]
      }
    }
  }

  depends_on = [kubernetes_manifest.constraint_template]
}

