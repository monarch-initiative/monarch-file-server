# Terraform variables

variable "project" { default = "monarch-initiative" }
variable "region" { default = "us-central1" }
variable "zone" { default = "us-central1-a" }
variable "credentials_file" { default = ".secrets/monarch-initiative-1f75a93635b2.json" }
variable "bucket_name" {default = "data-test.monarchinitiative.org"}


terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.1"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}
