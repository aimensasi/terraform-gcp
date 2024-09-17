variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "asia-southeast1"
}

variable "app_name" {
  description = "Application name to be pushed to the registery"
  type        = string
}

variable "github_app_id" {
  description = "Cloud build app id"
  type        = string
}

variable "github_repository" {
  description = "Repisotry URL"
  type = string
}

variable "cloud_build_file_path" {
  description = "Cloud buuild file path"
  type = string
}

variable "github_access_token" {
  description = "Github Access Token"
  type = string
}

variable "service_account" {
  description = "Service Account ID"
  type = string
}