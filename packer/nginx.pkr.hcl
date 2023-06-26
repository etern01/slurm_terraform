
variable  "image_tag" {
    type = string
}

source "yandex" "webserver" {
  folder_id           = "b1g5reegu63oulupmm6s"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  token               = ""
  use_ipv4_nat        = "true"
  image_name          = "nginx-${var.image_tag}"
  image_family        = "centos-web-server"
  image_description   = "my custom debian with nginx"
}

build {
  sources = ["source.yandex.webserver"]
  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
     ansible_ssh_extra_args = [
      "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa"
    ]
    extra_arguments = [ "--scp-extra-args", "'-O'" ]
  }

}
