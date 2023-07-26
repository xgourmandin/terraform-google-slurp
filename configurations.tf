locals {
  confs = {for c in var.api_configurations : c.name => c}
}


resource "google_firestore_document" "api_configuration" {
  for_each    = local.confs
  collection  = "slurp-api-configuration"
  document_id = each.key
  fields      = jsonencode({
    Name: each.value.name
    Url: each.value.url
    Method: each.value.method
    Active: true
    AdditionalHeaders: null
    AdditionalQueryParams: null
    AuthConfig: {
      AuthType: each.value.auth == null ? "None" : each.value.auth.type
      InHeader: each.value.auth == null ? null : each.value.auth.in_header
      TokenEnv: each.value.auth == null ? null : each.value.auth.token_env
      TokenParam: each.value.auth == null ? null : each.value.auth.token_param
    }
    DataConfig: {
      DataType: each.value.data.type
      DataRoot: each.value.data.root
    }
    OutputConfig: {
      OutputType: each.value.output == null ? "None" : each.value.output.type
      BucketName: each.value.output == null ? null : each.value.output.bucket
      FileName: each.value.output == null ? null : each.value.output.filename
      Project: each.value.output == null ? null : each.value.output.project
      Dataset: each.value.output == null ? null : each.value.output.dataset
      Table: each.value.output == null ? null : each.value.output.table
      Autodetect: each.value.output == null ? null : each.value.output.autodetect
    }
    PaginationConfig: {
      PaginationType: each.value.pagination == null ? "None" : each.value.pagination.type
      LimitParam: each.value.pagination == null ? null : each.value.pagination.limit_param
      PageParam: each.value.pagination == null ? null : each.value.pagination.page_param
      PageSize: each.value.pagination == null ? null : each.value.pagination.page_size
      NextLinkPath: each.value.pagination == null ? null : each.value.pagination.next_link_path
    }
  })
}