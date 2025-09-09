
resource "yandex_iam_service_account" "bucket_sa" {
  name        = var.sa_name
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id  = var.folder_id
  role       = "editor"
  members    = [
    "serviceAccount:${yandex_iam_service_account.bucket_sa.id}"
  ]
  depends_on = [ yandex_iam_service_account.bucket_sa ]
}

resource "yandex_resourcemanager_folder_iam_binding" "storage_admin" {
  folder_id  = var.folder_id
  role       = "storage.admin"
  members    = [
    "serviceAccount:${yandex_iam_service_account.bucket_sa.id}"
  ]
  depends_on = [ yandex_iam_service_account.bucket_sa ]
}

resource "yandex_iam_service_account_static_access_key" "sa_key" {
  service_account_id = yandex_iam_service_account.bucket_sa.id
}

resource "yandex_storage_bucket" "s3_backend" {
  bucket     = "${var.bucket_name}"
  access_key = yandex_iam_service_account_static_access_key.sa_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_key.secret_key
  acl        = "private"
  force_destroy = true
}

output "bucket_name" {
  value = yandex_storage_bucket.s3_backend.bucket
}

output "access_key" {
  value = yandex_iam_service_account_static_access_key.sa_key.access_key
}

output "secret_key" {
  value     = yandex_iam_service_account_static_access_key.sa_key.secret_key
  sensitive = true
}


