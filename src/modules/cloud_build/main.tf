# Cloud Build v2 connection with GitHub OAuth credentials
resource "google_cloudbuildv2_connection" "github_connection" {
  location = var.region
  name     = "github_connection"

  github_config {
    app_installation_id = var.github_app_id
    authorizer_credential {
      oauth_token_secret_version = var.github_access_token
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
  service_account = var.service_account
  location = var.region

  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
    #   branch = "feature-.*"
      branch = "^main$"
    }
  }

  filename = var.cloud_build_file_path

  depends_on = [
    google_cloudbuildv2_repository.github_repository
  ]
}


resource "google_cloudbuild_trigger" "build_trigger_v2" {
  name = "gcp-starter-build-trigger"
  location = var.region

  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
    #   branch = "feature-.*"
      branch = "^main$"
    }
  }

  filename = var.cloud_build_file_path

  depends_on = [
    google_cloudbuildv2_repository.github_repository
  ]
}
