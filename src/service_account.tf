resource "google_service_account" "sa" {
  account_id   = "terraform-sa"
  display_name = "Terraform Service Account"

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_binding" "sa_cloudbuild" {
  project = var.project_id
  role    = "roles/cloudbuild.editor"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]

  depends_on = [google_service_account.sa]
}

resource "google_project_iam_binding" "sa_run" {
  project = var.project_id
  role    = "roles/run.admin"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]

  depends_on = [google_service_account.sa]
}

resource "google_project_iam_binding" "sa_storage" {
  project = var.project_id
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]

  depends_on = [google_service_account.sa]
}

resource "google_project_iam_binding" "sa_secretmanager" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]

  depends_on = [google_service_account.sa]
}

resource "google_project_iam_binding" "sa_sql" {
  project = var.project_id
  role    = "roles/cloudsql.admin"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]

  depends_on = [google_service_account.sa]
}

resource "google_project_iam_binding" "sa_artifactregistry" {
  project = var.project_id
  role    = "roles/artifactregistry.admin"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]

  depends_on = [google_service_account.sa]
}


data "google_iam_policy" "secret_accessor_policy" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    // Here, 123456789 is the Google Cloud project number for the project that contains the connection.
    members = [
      "serviceAccount:${google_service_account.sa.email}",
      "serviceAccount:service-${var.project_id_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
    ]
  }
}

data "google_iam_policy" "secret_version_accessor_policy" {
  binding {
    role = "roles/secretmanager.versions.access"
    // Here, 123456789 is the Google Cloud project number for the project that contains the connection.
    members = [
      "serviceAccount:${google_service_account.sa.email}",
      "serviceAccount:service-${var.project_id_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
    ]
  }
}
