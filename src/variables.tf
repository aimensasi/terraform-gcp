variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "asia-southeast1"
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
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

variable "db_name" {
  description = "Name of database to create"
  type        = string
}

variable "github_app_id" {
  description = "Github App ID"
  type        = string
}
