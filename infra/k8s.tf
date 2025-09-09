

data "yandex_compute_image" "ubuntu-2204-lts" {
  family = var.vm_family
}

resource "yandex_compute_instance" "k8s" {
  for_each = {
  0 = "master"
  1 = "worker1"
  2 = "worker2"
  }

 lifecycle {
    ignore_changes = [boot_disk[0].initialize_params[0].image_id]
  }

  name = each.value
  platform_id  = var.k8s_platform_id
  zone = var.each_k8s_vm[each.key].zone

  resources {
    cores = var.each_k8s_vm[each.key].cpu
    memory = var.each_k8s_vm[each.key].ram
    core_fraction = var.each_k8s_vm[each.key].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.image_id
      size = var.each_k8s_vm[each.key].disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.each_k8s_vm[each.key].preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet[var.each_k8s_vm[each.key].subnet_index].id
    nat = var.each_k8s_vm[each.key].nat
    #security_group_ids = [yandex_vpc_security_group.k8s.id]
  }
  metadata = {
    user-data = "${file("./cloud-conf.yaml")}"
  }

}

