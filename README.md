## Terraform GCP Cloud Storage

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

This Terraform configuration defines a Google Cloud Storage bucket with advanced settings like versioning, lifecycle rules, logging, uniform access, and optional encryption. It also creates multiple GCS objects with custom metadata and caching options using a single template file. Retention policies and public access prevention are enforced to enhance security and compliance.

## Architecture

<img width="800" length="800" alt="Terraform" src="https://github.com/user-attachments/assets/805f3d68-5333-43bf-97be-1fd1a7fdffb8">


## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_gcp"></a> [gcp](#provider\_gcp) | 5.0.0   |

## Usage

```hcl
module "gcs_bucket" {
  source            = "./module"
  bucket_name       = var.bucket_name
  location          = var.location
  project_id        = var.project_id
  force_destroy     = var.force_destroy
  versioning        = var.versioning
  uniform_access    = var.uniform_access
  labels            = var.labels
  log_bucket        = var.log_bucket
  log_object_prefix = var.log_object_prefix
  lifecycle_age     = var.lifecycle_age
  kms_key_name      = var.kms_key_name
  retention_period  = var.retention_period
  storage_class     = var.storage_class
  objects           = var.objects
  empty_file_path   = var.empty_file_path
  content_type      = var.content_type
  cache_control     = var.cache_control
  object_metadata   = var.object_metadata
}

# Variable values

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

```

## Inputs

| Name | Description | Type | Default | Required | 
|------|-------------|:----:|---------|:--------:|
|**project_id**| The ID of the project | string | { } | yes| 
|**region**| Region where projects and folders will be created. | string | "us-central1" | yes | 
|**bucket_name**| Name of the GCS bucket | string| { }| yes| 
|**location**| Location for the GCS bucket | string | { } | yes | 
|**force_destroy**| Force destroy the bucket even if it contains objects | bool | true | yes| 
|**versioning**| Enable versioning for the bucket | bool | true | yes | 
|**uniform_access**| Enable uniform bucket-level access | bool | true | yes| 
|**labels**| Labels to apply to the bucket | map{string} | { } | yes | 
|**log_bucket**| Bucket to store access logs | string | null | yes| 
|**log_object_prefix**| Prefix for log object names | string | null | yes |
|**lifecycle_age**| Number of days after which to delete objects | number | 30 | yes | 
|**kms_key_name**| Optional KMS key for encryption | string| null | yes| 
|**retention_period**| Retention period for objects in seconds | number | 60 | yes | 
|**storage_class**| Storage class of the bucket | string | STANDARD | yes| 
|**objects**| List of object names to create inside the bucket | list(string) | [ ] | yes | 
|**empty_file_path**| Path to an empty or template file to upload | string | { } | yes| 
|**content_type**| Content-Type of uploaded objects | string | "plain/text" | yes | 
|**cache_control**| Bucket to store access logs | string | "no-cache" | yes| 
|**object_metadata**| Custom metadata to assign to each object | map(string) | { } | yes |

## Output
| Name | Description |
|------|-------------|
|**bucket_name**| Name of the bucket created | 
|**bucket_url**| URL of the bucket | 
