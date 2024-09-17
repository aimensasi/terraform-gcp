terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.2.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
  backend "gcs" {
    bucket = "dev-terraform-state-nova"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}


provider "docker" {
  host = "unix:///var/run/docker.sock"
}




module "okapi-hub-registry" {
  source = "./modules/artifact_registry"

  project_id      = var.project_id
  region          = var.region
  app_name        = "okapi-hub"
  repository_name = "okapi-hub-repo"

  depends_on = [google_project_service.artifact_registry]
}

module "okapi-hub-ci" {
  source = "./modules/cloud_build"

  project_id            = var.project_id
  region                = var.region
  app_name              = "okapi-hub"
  github_app_id         = var.github_app_id
  github_repository     = "https://github.com/aimensasi/okapi-hub"
  cloud_build_file_path = ".github/cloudbuild.yaml"
  github_access_token   = google_secret_manager_secret_version.secrets_versions["github_access_token"].name
  service_account = google_service_account.sa.id

  depends_on = [
    google_project_service.cloud_build,
    google_secret_manager_secret.secrets,
    google_secret_manager_secret_version.secrets_versions,
    google_secret_manager_secret_iam_policy.secrets_policies,
    google_project_service.secret_manager
  ]
}

module "okapi-hub-service" {
  source = "./modules/cloud_run"

  region   = var.region
  app_name = "okapi-hub"
  image    = "${var.region}-docker.pkg.dev/${var.project_id}/okapi-hub-repo/okapi-hub"
  db_connection_id = google_sql_database_instance.default.connection_name
  service_account = google_service_account.sa.email

  depends_on = [
    google_project_service.cloud_run,
    google_service_account.sa,
    google_sql_database_instance.default,
    module.okapi-hub-registry
  ]
}
