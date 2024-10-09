terraform {
  required_providers {
    previder = {
      source  = "previder/previder"
      version = "~> 1.0"
    }
  }
}

provider "previder" {
  token = var.portal_config_token
  url = var.portal_config_url
  customer = var.portal_config_customer
}
