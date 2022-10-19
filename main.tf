variable "GLUEOPS_ENV" {} 

variable "PROJECT_NAME" {
  type        = string
  description = "The name of the project"
}

variable "REGION" {
  type        = string
  description = "The region to deploy the Cloud SQL instance"
}

variable "DB_CLUSTER_NAME" {
  type        = string
  description = "The name of the Cloud SQL instance"
}
  
module "rerun" {
  source = "git::https://github.com/GlueOps/terraform-toggle-rerun-for-tfc-operator.git?ref=v0.1.0"
}

resource "vault_generic_secret" "example" {
  path = "secret/${var.GLUEOPS_ENV}/${var.DB_CLUSTER_NAME}"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}
  
  
# provider "google" {
#   project = local.project_name
# }


# locals {
#   project_name = var.PROJECT_NAME #"yolo1-apps-141715"
#   pg_version = {
#     pg_provider_version = "14.0.0"
#     cloud_sql_version   = "POSTGRES_14"
#   }

#   region = var.REGION #"us-central1"

# }

# resource "google_sql_database_instance" "instance" {
#   project          = local.project_name
#   name             = var.DB_CLUSTER_NAME #"glueops-db"
#   region           = local.region
#   database_version = local.pg_version.cloud_sql_version
#   settings {
#     tier              = "db-f1-micro"
#     availability_type = "ZONAL"


#     insights_config {
#       query_insights_enabled  = false
#       query_string_length     = 1024
#       record_application_tags = false
#       record_client_address   = false
#     }



#     maintenance_window {
#       day          = 2
#       hour         = 7
#       update_track = "stable"
#     }


#     backup_configuration {
#       enabled                        = true
#       start_time                     = "07:00"
#       point_in_time_recovery_enabled = true
#       transaction_log_retention_days = 7
#       backup_retention_settings {
#         retained_backups = 3
#       }

#     }
#   }

#   deletion_protection = true
# }
