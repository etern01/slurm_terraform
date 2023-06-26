variable "image_id" {
  type        = string
  description = "Default image id"
}


variable "instance_group_name" {
  type        = string
  description = "Default name"
}

variable "ipv4_cidr_blocks" {
  type        = list(list(string))
  description = "List of ipv4"

}

variable "labels" {
  type = map(string)

}

variable "resources" {
  type = object({
    cores  = number
    disk   = number
    memory = number
  })

}

variable "lb-port" {
  type        = number
  description = "port for lb"
  default     = 80
}

variable "healthcheck-lb" {
  type = object({
    timeout = string
    interval = string
    path = string
  })

}

variable "az" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]

}

variable "public_ssh_key_path" {
  type = string

}

variable "vm_count" {
  type        = number
  description = "Number of vm"

}

variable "folder_id" {
  type        = string
  description = "folder id"

}