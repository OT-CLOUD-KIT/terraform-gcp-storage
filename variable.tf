variable "prefix" {
  description = "Prefix used to generate the bucket name."
  type        = string
}

variable "names" {
  description = "Bucket name suffixes."
  type        = list(string)
}

variable "randomize_suffix" {
  description = "Adds an identical, but randomized 2-character suffix to all bucket names"
  type        = bool
  default     = false
}

variable "location" {
  description = "Bucket location."
  type        = string
}

variable "storage_class" {
  description = "Bucket storage class."
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  type        = map(bool)
  default     = {}
}

variable "versioning" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  type        = map(bool)
  default     = {}
}

variable "encryption_key_names" {
  description = "Optional map of lowercase unprefixed name => string, empty strings are ignored."
  type        = map(string)
  default     = {}
}

variable "bucket_policy_only" {
  description = "Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean"
  type        = map(bool)
  default     = {}
}

variable "labels" {
  description = "Labels to be attached to the buckets"
  type        = map(string)
  default     = {}
}

variable "folders" {
  description = "Map of lowercase unprefixed name => list of top level folder objects."
  type        = map(list(string))
  default     = {}
}

variable "lifecycle_rules" {
  type = set(object({
    action = map(string)
    condition = map(string)
  }))
  description = "List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches_storage_class should be a comma delimited string."
  default     = []
}

variable "cors" {
  description = "Set of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors"
  type        = set(any)
  default     = []
}

variable "website" {
  type        = map(any)
  default     = {}
  description = "Map of website values. Supported attributes: main_page_suffix, not_found_page"
}

variable "retention_policy" {
  type        = any
  default     = {}
  description = "Map of retention policy values. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket#retention_policy"
}

variable "logging" {
  description = "Map of lowercase unprefixed name => bucket logging config object. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#logging"
  type        = any
  default     = {}
}
