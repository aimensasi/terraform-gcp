resource "google_artifact_registry_repository" "cloud_run_source_deploy" {
  project       = var.project_id
  location      = var.region
  description   = "Cloud Run Source Deployments"
  format        = "DOCKER"
  repository_id = "${var.env}-${var.app_name}-app"

  depends_on = [ google_project_service.artifact_registry ]
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
  platform = "linux/amd64"
}

resource "null_resource" "push_image_to_registry" {
  provisioner "local-exec" {
    command = <<EOT
      docker tag nginx:latest ${var.region}-docker.pkg.dev/${var.project_id}/${var.env}-${var.app_name}-app/app:latest &&
      docker push ${var.region}-docker.pkg.dev/${var.project_id}/${var.env}-${var.app_name}-app/app:latest
    EOT
  }

  depends_on = [docker_image.nginx, google_artifact_registry_repository.cloud_run_source_deploy]
}
