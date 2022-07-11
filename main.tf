resource "google_storage_bucket" "buckets" {
  for_each = local.names_set
  name          = "${local.prefix}${lower(each.value)}${local.suffix}"
  location      = var.location
  storage_class = var.storage_class
  labels        = merge(var.labels, { name = replace("${local.prefix}${lower(each.value)}", ".", "-") })
  force_destroy = lookup(
    var.force_destroy,
    lower(each.value),
    false,
  )
  uniform_bucket_level_access = lookup(
    var.bucket_policy_only,
    lower(each.value),
    true,
  )
  versioning {
    enabled = lookup(
      var.versioning,
      lower(each.value),
      false,
    )
  }

  dynamic "encryption" {
    for_each = trimspace(lookup(var.encryption_key_names, lower(each.value), "")) != "" ? [true] : []
    content {
      default_kms_key_name = trimspace(
        lookup(
          var.encryption_key_names,
          lower(each.value),
          "Error retrieving kms key name",
        )
      )
    }
  }
  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? toset([]) : toset([var.website])
    content {
      main_page_suffix = lookup(website.value, "main_page_suffix", null)
      not_found_page   = lookup(website.value, "not_found_page", null)
    }
  }
  dynamic "cors" {
    for_each = var.cors
    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }
  dynamic "retention_policy" {
    for_each = lookup(var.retention_policy, each.value, {}) != {} ? [var.retention_policy[each.value]] : []
    content {
      is_locked        = lookup(retention_policy.value, "is_locked", null)
      retention_period = lookup(retention_policy.value, "retention_period", null)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", lookup(lifecycle_rule.value.condition, "is_live", false) ? "LIVE" : null)
        matches_storage_class      = contains(keys(lifecycle_rule.value.condition), "matches_storage_class") ? split(",", lifecycle_rule.value.condition["matches_storage_class"]) : null
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        custom_time_before         = lookup(lifecycle_rule.value.condition, "custom_time_before", null)
        days_since_custom_time     = lookup(lifecycle_rule.value.condition, "days_since_custom_time", null)
        days_since_noncurrent_time = lookup(lifecycle_rule.value.condition, "days_since_noncurrent_time", null)
        noncurrent_time_before     = lookup(lifecycle_rule.value.condition, "noncurrent_time_before", null)
      }
    }
  }

  dynamic "logging" {
    for_each = lookup(var.logging, each.value, {}) != {} ? { v = lookup(var.logging, each.value) } : {}
    content {
      log_bucket        = lookup(logging.value, "log_bucket", null)
      log_object_prefix = lookup(logging.value, "log_object_prefix", null)
    }
  }
}

resource "google_storage_bucket_object" "folders" {
  for_each = { for obj in local.folder_list : "${obj.bucket}_${obj.folder}" => obj }
  bucket   = google_storage_bucket.buckets[each.value.bucket].name
  name     = "${each.value.folder}/"
  content  = "foo"
}