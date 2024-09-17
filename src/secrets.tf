
variable "secrets" {
  sensitive = true
  type = map(object({
    secret_id   = string
    secret_data = string
  }))
}

variable "secres_keys" {
  type = set(string)
  default = ["db_username", "db_password", "github_access_token"]
}

resource "google_secret_manager_secret" "secrets" {
  for_each = var.secres_keys

  secret_id = each.value

  replication {
    user_managed {
      replicas {
        location = "asia-southeast1" # Singapore
      }
      replicas {
        location = "asia-east2" # Hong Kong
      }
      replicas {
        location = "asia-northeast1" # Tokyo
      }
    }
  }

  depends_on = [google_project_service.secret_manager]
}

resource "google_secret_manager_secret_version" "secrets_versions" {
  for_each = var.secres_keys

  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = var.secrets[each.key].secret_data

  depends_on = [google_secret_manager_secret.secrets]
}

resource "google_secret_manager_secret_iam_policy" "secrets_policies" {
  for_each = var.secres_keys

  secret_id   = google_secret_manager_secret.secrets[each.key].secret_id
  policy_data = data.google_iam_policy.secret_accessor_policy.policy_data

  depends_on = [
    google_secret_manager_secret.secrets,
    data.google_iam_policy.secret_accessor_policy
  ]
}
