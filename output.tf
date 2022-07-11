output "names" {
  description = "Bucket names."
  value = { for name, bucket in google_storage_bucket.buckets :
    name => bucket.name
  }
}

output "urls" {
  description = "Bucket URLs."
  value = { for name, bucket in google_storage_bucket.buckets :
    name => bucket.url
  }
}

output "names_list" {
  description = "List of bucket names."
  value       = local.buckets_list[*].name
}

output "urls_list" {
  description = "List of bucket URLs."
  value       = local.buckets_list[*].url
}