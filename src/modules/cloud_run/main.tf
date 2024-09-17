resource "google_cloud_run_v2_service" "service" {
  name     = "${var.app_name}-service"
  location = var.region
  deletion_protection = false

  template {
    revision = "${var.app_name}-service-revision-${formatdate("YYYYMMDDhhmmss", timestamp())}"
    containers {
      image = var.image
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
}
