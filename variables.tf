//
// Variables specific to module label
//
variable "attributes" {
  description = "Suffix name with additional attributes (policy, role, etc.)"
  type        = "list"
  default     = []
}

variable "component" {
  description = "TAG: Underlying, dedicated piece of service (Cache, DB, ...)"
  type        = "string"
  default     = "UNDEF-S3-Buckets"
}

variable "delimiter" {
  description = "Delimiter to be used between `name`, `namespaces`, `attributes`, etc."
  type        = "string"
  default     = "-"
}

variable "environment" {
  description = "Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options)"
  type        = "string"
}

variable "monitor" {
  description = "TAG: Should resource be monitored"
  type        = "string"
  default     = "UNDEF-S3-Buckets"
}

variable "names" {
  description = "List of S3 bucket names"
  type        = "list"
}

variable "namespace-env" {
  description = "Prefix name with the environment. If true, format is: <env>-<name>"
  default     = true
}

variable "namespace-org" {
  description = "Prefix name with the organization. If true, format is: <org>-<env namespaced name>. If both env and org namespaces are used, format will be <org>-<env>-<name>"
  default     = true
}

variable "organization" {
  description = "Organization name (Top level namespace)"
  type        = "string"
  default     = ""
}

variable "owner" {
  description = "TAG: Owner of the service"
  type        = "string"
  default     = "UNDEF-S3-Buckets"
}

variable "product" {
  description = "TAG: Company/business product"
  type        = "string"
  default     = "UNDEF-S3-Buckets"
}

variable "service" {
  description = "TAG: Application (microservice) name"
  type        = "string"
  default     = "UNDEF-S3-Buckets"
}

variable "tags" {
  description = "A map of additional tags"
  type        = "map"
  default     = {}
}

variable "team" {
  description = "TAG: Department/team of people responsible for service"
  type        = "string"
  default     = "UNDEF-S3-Buckets"
}

// Module specific Variables
variable "enabled" {
  description = "Set to false to prevent the module from creating anything"
  default     = true
}

variable "principal" {
  description = "principal"
  default     = "*"
}

variable "public" {
  description = "Allow public read access to bucket"
  default     = false
}

variable "versioned" {
  description = "Version the bucket"
  default     = false
}
