resource "google_cloud_run_v2_service" "service" {
  name     = "${var.env}-${var.app_name}-service"
  location = var.region
  deletion_protection = false

  template {
    revision = "${var.env}-${var.app_name}-service-revision-${formatdate("YYYYMMDDhhmmss", timestamp())}"
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.env}-${var.app_name}-app/app:latest"
      ports {
        container_port = 80
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }
    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.default.connection_name]
      }
    }
    service_account = google_service_account.sa.email
  }

  depends_on = [
    google_project_service.cloud_run,
    google_service_account.sa,
    google_sql_database_instance.default,
    null_resource.push_image_to_registry
  ]
}
