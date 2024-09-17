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
    bucket  = "dev-terraform-state-nova"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "docker" {
    host = var.docker_demon_host
}



# module "okapi-hub-registry" {
#   source = "./modules/artifact_registry"

#   project_id = var.project_id
#   region = var.region
#   app_name = "okapi-hub"
#   repository_name = "okapi-hub-repo"
# }

# module "okapi-hub-ci" {
#   source = "./modules/cloud_build"

#   project_id = var.project_id
#   region = var.region
#   app_name = "okapi-hub"
#   github_app_id = ""
#   github_repository = "okapi-hub-repo"
#   cloud_build_file_path = ""
# }

# module "okapi-hub-service" {
#   source = "./modules/cloud_run"

#   region = var.region
#   app_name = "okapi-hub"
#   image = ""
# }