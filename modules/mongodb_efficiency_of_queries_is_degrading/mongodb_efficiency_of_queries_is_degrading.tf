resource "shoreline_notebook" "mongodb_efficiency_of_queries_is_degrading" {
  name       = "mongodb_efficiency_of_queries_is_degrading"
  data       = file("${path.module}/data/mongodb_efficiency_of_queries_is_degrading.json")
  depends_on = [shoreline_action.invoke_mongo_creds]
}

resource "shoreline_file" "mongo_creds" {
  name             = "mongo_creds"
  input_file       = "${path.module}/data/mongo_creds.sh"
  md5              = filemd5("${path.module}/data/mongo_creds.sh")
  description      = "Define variables"
  destination_path = "/agent/scripts/mongo_creds.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_mongo_creds" {
  name        = "invoke_mongo_creds"
  description = "Define variables"
  command     = "`chmod +x /agent/scripts/mongo_creds.sh && /agent/scripts/mongo_creds.sh`"
  params      = ["MONGODB_USER","MONGODB_PASSWORD","MONGODB_PORT","MONGODB_HOST"]
  file_deps   = ["mongo_creds"]
  enabled     = true
  depends_on  = [shoreline_file.mongo_creds]
}

