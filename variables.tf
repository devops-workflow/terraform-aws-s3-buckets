

// Standard Variables

variable "names" {
  description = "List of S3 bucket names"
  type        = "list"
}
variable "environment" {
  description = "Environment (ex: dev, qa, stage, prod)"
}
variable "namespaced" {
  description = "Namespace all resources (prefixed with the environment)?"
  default     = true
}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "org" {
  description = "Organization name to prefix S3 buckets with"
}

// Module specific Variables

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
