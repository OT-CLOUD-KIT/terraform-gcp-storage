# GCP cloud Storage

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

  - This terraform module will create storage buckets.
  - This project is a part of opstree's ot-gcp initiative for terraform modules.

# Overview of GCP cloud storage
Google Cloud Storage is an enterprise public cloud storage platform that can house large unstructured data sets. Companies can purchase the storage for primary or infrequently accessed data. Google Cloud Storage customers access their data through a web browser or command-line interface

## Usage

```
terraform {
  required_providers {
    google = {
      version = "~> 4.19.0"
    }
  }
  required_version = "~>1.1.3"
}

# Configure the GCP Provider

provider "google" {
  credentials = file("<service_account_key_json/p12_file")
  project     = "<project-id>"
  region      = "<region>"
}

#Basic use of this module:

module "cloud_storage" {
  source     = "OT-CLOUD-KIT/gcp/storage"
  prefix     = "opstree-"
  location   = "<bucket location>"

  names = ["dev", "qa"]
  bucket_policy_only = {
    "dev" = false
    "qa"  = true
  }
  folders = {
    "dev" = ["test1", "test2"]
  }

  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age                   = "730"
      matches_storage_class = "STANDARD"
      with_state = "ANY"
    }
  }]
}

```

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | Prefix used to generate the bucket name. | `string` | n/a | yes |
| names | Bucket name suffixes. | `list(string)` | n/a | yes |
| location | Bucket location. | `string` | n/a | no |
| storage_class | Bucket storage class. | `string` | `STANDARD` | no |
| force_destroy | Bucket storage class. | `bool` | `false` | no |
| versioning | Optional map of lowercase unprefixed name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| encryption_key_names | The bucket's encryption configuration. | `map(string)` | n/a | no |
| labels | Labels to be attached to the buckets | `map(string)` | `{}` | no |
| folders | Map of lowercase unprefixed name => list of top level folder objects. | `map(list(string))` | `{}` | no |
| lifecycle\_rules | List of lifecycle rules to configure.| `[]` | no |
| cors | Set of maps of mixed type attributes for CORS values. | `set(any)` | `[]` | no |
| website | Map of website values. Supported attributes: main\_page\_suffix, not\_found\_page | `map(any)` | `{}` | no |
| retention\_policy | Map of retention policy values. | `any` | `{}` | no |
| logging | Map of lowercase unprefixed name => bucket logging config object. | `any` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| names | Bucket names. |
| names\_list | List of bucket names. |
| url | Bucket URL (for single use). |
| urls | Bucket URLs. |
| urls\_list | List of bucket URLs. |


### Contributors

[![Shweta Tyagi][shweta_avatar]][shweta_homepage]<br/>[Shweta Tyagi][shweta_homepage] 

  [shweta_homepage]: https://github.com/shwetatyagi-ot
  [shweta_avatar]: https://img.cloudposse.com/75x75/https://github.com/shwetatyagi-ot.png