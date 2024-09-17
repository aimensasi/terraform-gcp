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
