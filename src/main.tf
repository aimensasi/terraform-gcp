terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 6.2.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
  backend "gcs" {
    bucket  = "nova-terraform-state-sample-2030"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file(var.credentials_file)
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}


# This need to be created manually first and then define name on top
# resource "google_storage_bucket" "terraform_state" {
#   name     = "nova-terraform-state-sample-2029"
#   location = var.region
#   force_destroy = true

#   versioning {
#     enabled = true
#   }

#   lifecycle_rule {
#     action {
#       type = "Delete"
#     }
#     condition {
#       age = 365
#     }
#   }
# }
