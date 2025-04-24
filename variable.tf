variable "bucket_name" {
  description = "Name of the GCS bucket."
  type        = string
}

variable "location" {
  description = "Location for the GCS bucket."
  type        = string
}

variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "force_destroy" {
  description = "Force destroy the bucket even if it contains objects."
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Enable versioning for the bucket."
  type        = bool
  default     = true
}

variable "uniform_access" {
  description = "Enable uniform bucket-level access."
  type        = bool
  default     = true
}

variable "labels" {
  description = "Labels to apply to the bucket."
  type        = map(string)
  default     = {}
}

variable "log_bucket" {
  description = "Bucket to store access logs."
  type        = string
  default     = null
}

variable "log_object_prefix" {
  description = "Prefix for log object names."
  type        = string
  default     = null
}

variable "lifecycle_age" {
  description = "Number of days after which to delete objects."
  type        = number
  default     = 30
}

variable "kms_key_name" {
  description = "Optional KMS key for encryption."
  type        = string
  default     = null
}

variable "retention_period" {
  description = "Retention period for objects in seconds."
  type        = number
  default     = 60
}

variable "storage_class" {
  description = "Storage class of the bucket."
  type        = string
  default     = "STANDARD"
}

variable "objects" {
  description = "List of object names to create inside the bucket."
  type        = list(string)
}

variable "empty_file_path" {
  description = "Path to an empty or template file to upload."
  type        = string
}

variable "content_type" {
  description = "Content-Type of uploaded objects."
  type        = string
  default     = "text/plain"
}

variable "cache_control" {
  description = "Cache control settings for objects."
  type        = string
  default     = "no-cache"
}

variable "object_metadata" {
  description = "Custom metadata to assign to each object."
  type        = map(string)
  default     = {}
}
