terraform {
  required_version = ">= 1.12"

  backend "atlas" {
    name         = "datacite-ng/test-services-client-api"
  }
}
