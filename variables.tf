variable "subscription_id" {
  type = string
  default = "6dc62d41-f999-47b4-9f66-c60bf6560550"
}

variable "tags_prod_management" {
  type = map(string)
  default = {
    CanBeDeleted = "True"
    Environment  = "Production"
    Owner        = "Jimmy Hildingsson"
    Deployment   = "GitHub Actions"
    CodeStack    = "Terraform"
    Workload     = "Management"
  }
}

variable "tags_prod_identity" {
  type = map(string)
  default = {
    CanBeDeleted = "True"
    Environment  = "Production"
    Owner        = "Jimmy Hildingsson"
    Deployment   = "GitHub Actions"
    CodeStack    = "Terraform"
    Workload     = "Identity"
  }
}

variable "tags_test_app-registration-monitoring" {
  type = map(string)
  default = {
    CanBeDeleted = "True"
    Environment  = "Test"
    Owner        = "Jimmy Hildingsson"
    Deployment   = "GitHub Actions"
    CodeStack    = "Terraform"
    Workload     = "App Registration Monitoring"
  }
}

variable "tags_prod_web-application" {
  type = map(string)
  default = {
    CanBeDeleted = "True"
    Environment  = "Production"
    Owner        = "Jimmy Hildingsson"
    Deployment   = "GitHub Actions"
    CodeStack    = "Terraform"
    Workload     = "Web Application"
  }
}