
provider "google" {
  project = local.project_name
}


locals {
  project_name = "yolo1-apps-141715"
  pg_version = {
    pg_provider_version = "14.0.0"
    cloud_sql_version   = "POSTGRES_14"
  }

  region = "us-central1"

}

resource "google_sql_database_instance" "instance" {
  project          = local.project_name
  name             = "glueops-db"
  region           = local.region
  database_version = local.pg_version.cloud_sql_version
  settings {
    tier              = "db-custom-1-3840"
    availability_type = "ZONAL"


    insights_config {
      query_insights_enabled  = false
      query_string_length     = 1024
      record_application_tags = false
      record_client_address   = false
    }



    maintenance_window {
      day          = 2
      hour         = 7
      update_track = "stable"
    }


    backup_configuration {
      enabled                        = true
      start_time                     = "07:00"
      point_in_time_recovery_enabled = true
      transaction_log_retention_days = 7
      backup_retention_settings {
        retained_backups = 90
      }

    }
  }

  deletion_protection = true
}
variable "TOGGLE_TO_RETRY" {
    description = "Boolean designating a FIFO queue"
  type        = string
  default     = false
}


resource "random_integer" "priority" {
  min = 1
  max = 50000
  keepers = {
    number = var.TOGGLE_TO_RETRY
  }
}

output "random_priority" {
  value = random_integer.priority.result
}