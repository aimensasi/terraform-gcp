variable "env" {
  description = "The target environment"
  type        = string
  default = "dev"
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "asia-southeast1"
}

variable "project_id_number" {
  description = "The number representation of the GCP project"
  type        = string
}
variable "docker_demon_host" {
  description = "The demon used to run docker"
  type = string
  default = "unix:///var/run/docker.sock"
}

variable "app_name" {
  description = "The app name"
  type        = string
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "db_name" {
  description = "Name of database to create"
  type        = string
}

variable "github_app_id" {
  description = "Github App ID"
  type        = string
}

variable "cloud_build_file_path" {
    description = "The path of the cloud build config file"
    type = string
    default = "cloudbuild.yaml"
}
