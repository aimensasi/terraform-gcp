variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "asia-southeast1"
}

variable "app_name" {
  description = "Application name to be pushed to the registery"
  type        = string
}

variable "image" {
  description = "The image path to be used for the cloud run service"
  type = string
}

variable "db_connection_id" {
  description = "Database Instance ID"
  type        = string
}

variable "service_account" {
  description = "Service Account Email"
  type = string
}