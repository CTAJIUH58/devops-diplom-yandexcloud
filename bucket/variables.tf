#PROVIDER VARS
variable "cloud_id" {
  type        = string
  default     = "b1ge8ac59kbr0jvvl38e"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1g9e0n72sa8lujhtbln"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

#S3 BACKEND VARS
variable "sa_name" {
  type        = string
  default     = "bucket-sa"
}

variable "bucket_name" {
  type        = string
  default     = "s3backend"
}