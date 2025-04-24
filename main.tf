resource "google_storage_bucket" "gcp-bucket" {
  name                        = var.bucket_name
  location                    = var.location
  force_destroy               = var.force_destroy
  project                     = var.project_id
  storage_class               = var.storage_class
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = var.uniform_access

  versioning {
    enabled = var.versioning
  }

  labels = var.labels

  logging {
    log_bucket        = var.log_bucket
    log_object_prefix = var.log_object_prefix
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = var.lifecycle_age
    }
  }

  dynamic "encryption" {
    for_each = var.kms_key_name != null ? [1] : []
    content {
      default_kms_key_name = var.kms_key_name
    }
  }

  retention_policy {
    retention_period = var.retention_period
    is_locked        = false
  }
}

resource "google_storage_bucket_object" "object" {
  for_each = toset(var.objects)

  name          = each.value
  bucket        = google_storage_bucket.gcp-bucket.name
  source        = var.empty_file_path
  content_type  = var.content_type
  cache_control = var.cache_control
  metadata      = var.object_metadata
}