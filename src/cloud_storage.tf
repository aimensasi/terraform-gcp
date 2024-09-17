# Define the Google Cloud Storage bucket
resource "google_storage_bucket" "bucket" {
  name          = "${var.env}-${var.bucket_name}"
  location      = var.region
  storage_class = "STANDARD"
  force_destroy = true
  uniform_bucket_level_access = false

  depends_on = [google_project_service.storage]
}

resource "google_storage_bucket_iam_member" "cloud_run_service_account_access" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.sa.email}"
}
