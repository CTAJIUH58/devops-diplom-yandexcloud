locals {

  vm_roles = {
    0 = "master"
    1 = "worker1"
    2 = "worker2"
  }

  hosts = {
    for vm_name, instance in yandex_compute_instance.k8s : local.vm_roles[vm_name] => {
      ansible_host = instance.network_interface.0.nat_ip_address
      access_ip    = instance.network_interface.0.nat_ip_address
      ip           = instance.network_interface.0.ip_address
      ansible_user = "user"
    }
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("./inventory.tmpl", {
    hosts = local.hosts
  })
  filename = "./k8s_inventory.yml"
}