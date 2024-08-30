variable "tags" {
  type = map(string)
  default = {
    CanBeDeleted = "True"
    Environment  = "Development"
    Owner        = "Jimmy Hildingsson"
    Deployment   = "GitHub Actions"
    CodeStack    = "Terraform"
    Workload     = "App Registration Monitoring"
  }
}

variable "subscription_id" {
  type = string
  default = "6dc62d41-f999-47b4-9f66-c60bf6560550"
}