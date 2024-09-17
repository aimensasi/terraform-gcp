resource "google_sql_database_instance" "default" {
  name             = "${var.env}-db-instance"
  database_version = "MYSQL_8_0"
  region           = var.region
  deletion_protection=false

  settings {
    tier = "db-f1-micro"
    # service_account = google_service_account.sa.email
    ip_configuration {
      ipv4_enabled = true
    }

    backup_configuration {
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }

      binary_log_enabled             = true
      enabled                        = true
      location                       = "asia"
      start_time                     = "04:00"
      transaction_log_retention_days = 7
    }
  }

  depends_on = [ google_project_service.cloud_sql  ]
}

resource "google_sql_user" "default_user" {
  name     = var.secrets["db_username"].secret_data
  password = var.secrets["db_password"].secret_data
  host = "%"
  instance = google_sql_database_instance.default.name

  depends_on = [ google_sql_database_instance.default ]
}

resource "google_sql_database" "db_name" {
  name     = var.db_name
  instance = google_sql_database_instance.default.name

  depends_on = [ google_sql_database_instance.default ]
}


