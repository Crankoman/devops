locals {
    web = {
      env     = "develop"
      project = "platform"
      role    = "web"
    }
    db = {
      env     = "develop"
      project = "platform"
      role    = "db"
    }
}

locals {
  platform_name = "netology-${ local.web.env }-${ local.web.project }-${ local.web.role}"
  platform_db_name  = "netology-${ local.db.env }-${ local.db.project }-${ local.db.role}"
}