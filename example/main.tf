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
  location   = "uae"

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