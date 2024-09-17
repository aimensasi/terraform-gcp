variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "asia-southeast1"
}

variable "repository_name" {
  description = "The respitory name"
  type        = string
}

variable "app_name" {
  description = "Application name to be pushed to the registery"
  type        = string
}