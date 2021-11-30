# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

resource "google_storage_bucket" "monarch_file_server" {

  name       = var.bucket_name
  location   = "US"
  force_destroy = true

  storage_class = "STANDARD"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      num_newer_versions = 2
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      days_since_noncurrent_time = 7
    }
    action {
      type = "Delete"
    }
  }

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

}

resource "google_storage_bucket_iam_member" "member" {
  bucket = var.bucket_name
  role = "roles/storage.objectViewer"
  member = "allUsers"

  depends_on = [
    google_storage_bucket.monarch_file_server,
  ]
}
