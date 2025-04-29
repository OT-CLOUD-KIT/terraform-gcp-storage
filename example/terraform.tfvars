region = "us-central1"

project_id = "nw-opstree-dev-landing-zone"

bucket_name = "jaiswal-bucket"

location = "US"

versioning = true

force_destroy = true

objects = ["env/dev/network/tfstate", "env/dev/vm/tfstate"]

empty_file_path = "blank.txt"

uniform_access = true

labels = {
  env  = "dev"
  team = "infra"
}
log_bucket = "gcs-log-bucket"

log_object_prefix = "gcs-logs"

lifecycle_age = 30

kms_key_name = null

retention_period = 30

storage_class = "STANDARD"

content_type = "text/plain"

cache_control = "no-cache"

object_metadata = {
  owner = "devops"
}
