variable "env" {
  description = "The target environment"
  type        = string
  default = "dev"
}

variable "app_name" {
  description = "The app name"
  type        = string
}

variable "image_name" {
  description = "The image name"
  type        = string
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "project_id_number" {
  description = "The number representation of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "asia-southeast1"
}

variable "credentials_file" {
  description = "Path to the service account credentials file"
  type        = string
}

variable "bucket_name" {
  description = "Name of storage bucket"
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
