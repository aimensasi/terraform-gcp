terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}


resource "google_artifact_registry_repository" "artificate_registery" {
  project       = var.project_id
  location      = var.region
  description   = "Artificate Registery"
  format        = "DOCKER"
  repository_id = var.repository_name
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
  platform = "linux/amd64"
}

resource "null_resource" "push_image_to_registry" {
  provisioner "local-exec" {
    command = <<EOT
      docker tag nginx:latest \
        ${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_name}/${var.app_name}:latest &&
      docker push ${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_name}/${var.app_name}:latest
    EOT
  }

  depends_on = [docker_image.nginx, google_artifact_registry_repository.artificate_registery]
}
