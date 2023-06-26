resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "private_key" {
  count           = var.public_ssh_key_path != "" ? 0 : 1
  content         = tls_private_key.ssh.private_key_pem
  filename        = "key.pem"
  file_permission = "0600"
}
