output "bucket_name" {
  description = "The name of the created GCS bucket"
  value       = google_storage_bucket.gcp-bucket.name
}

output "bucket_url" {
  description = "Public URL for the bucket (if public)"
  value       = "gs://${google_storage_bucket.gcp-bucket.name}"
}