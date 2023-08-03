terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "mongodb_efficiency_of_queries_is_degrading" {
  source    = "./modules/mongodb_efficiency_of_queries_is_degrading"

  providers = {
    shoreline = shoreline
  }
}