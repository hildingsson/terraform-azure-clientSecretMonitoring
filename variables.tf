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