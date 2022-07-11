resource "random_id" "bucket_suffix" {
  byte_length = 2
}

locals {
  prefix       = var.prefix
  suffix       = var.randomize_suffix ? "-${random_id.bucket_suffix.hex}" : ""
  names_set    = toset(var.names)
  buckets_list = [for name in var.names : google_storage_bucket.buckets[name]]
  first_bucket = local.buckets_list[0]
  folder_list = flatten([
    for bucket, folders in var.folders : [
      for folder in folders : {
        bucket = bucket,
        folder = folder
      }
    ]
  ])
}