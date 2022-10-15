variable "TOGGLE_TO_RERUN" { default = "" }

module "rerun" {
  source    = "git::https://github.com/GlueOps/terraform-toggle-rerun-for-tfc-operator.git"
  TOGGLE_TO_RERUN  = var.TOGGLE_TO_RERUN
}
