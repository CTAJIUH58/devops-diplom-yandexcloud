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

#VPC VARS
variable "vpc_name" {
  type        = string
  default     = "diplom-vpc"
}

variable "public_subnet_name" {
  type        = string
  default     = "public"
}

variable "public_v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.10.0/24","192.168.11.0/24","192.168.12.0/24"]
}

variable "subnet_zone" {
  type        = string
  default     = "ru-central1"
}

variable "public_subnet_zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b",  "ru-central1-d"]
}

#K8S VARS

variable "vm_family" {
  type        = string
  default = "ubuntu-2204-lts"
}

variable "k8s_platform_id" {
  type = string
  default = "standard-v1"
}

variable "each_k8s_vm" {
  type = list(object(
  { vm_name=string, 
    cpu=number, 
    ram=number, 
    disk_volume=number, 
    core_fraction=number,
    preemptible=bool,
    nat=bool,
    subnet_index=number
    zone=string
  }))
  default = [
    {
      vm_name       = "master"
      cpu           = 2
      ram           = 4
      disk_volume   = 30
      core_fraction = 20
      preemptible   = false
      nat           = true
      subnet_index = 0
      zone = "ru-central1-a"
    },
    {
      vm_name       = "worker1"
      cpu           = 2
      ram           = 4
      disk_volume   = 30
      core_fraction = 20
      preemptible   = true
      nat           = true
      subnet_index = 0
      zone = "ru-central1-a"
    },
    {
      vm_name       = "worker2"
      cpu           = 2
      ram           = 4
      disk_volume   = 30
      core_fraction = 20
      preemptible   = true
      nat           = true
      subnet_index = 1
      zone = "ru-central1-b"
    }
  ]
}

