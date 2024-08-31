variable "subscription_id" {
  type = string
  default = "6dc62d41-f999-47b4-9f66-c60bf6560550"
}

variable "tags_connectivity" {
  type = map(string)
  default = {
    CanBeDeleted = "True"
    Environment  = "Production"
    Owner        = "Jimmy Hildingsson"
    Deployment   = "GitHub Actions"
    CodeStack    = "Terraform"
    Workload     = "Connectivity Resources"
  }
}