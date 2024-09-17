# Cloud Build v2 connection with GitHub OAuth credentials
resource "google_cloudbuildv2_connection" "github_connection" {
  location = var.region
  name     = "github_connection"

  github_config {
    app_installation_id = var.github_app_id
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.secrets_versions["github_access_token"].name
    }
  }
}

resource "google_cloudbuildv2_repository" "github_repository" {
  location          = var.region
  name              = var.app_name
  parent_connection = google_cloudbuildv2_connection.github_connection.name
  remote_uri        = var.github_repository

  depends_on = [google_cloudbuildv2_connection.github_connection]
}

resource "google_cloudbuild_trigger" "build_trigger" {
  name = "gcp-starter-build-trigger"
  service_account = google_service_account.sa.id
  location = var.region

  repository_event_config {
    repository = google_cloudbuildv2_repository.gcp_starter_repo.id
    push {
    #   branch = "feature-.*"
      branch = "^main$"
    }
  }

  filename = var.cloud_build_file_path

  depends_on = [
    google_cloudbuildv2_repository.gcp_starter_repo
  ]
}
