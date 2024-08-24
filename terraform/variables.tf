variable "user" {
  description = "Username for SSH"
  default     = "hmedeiros"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key for SSH access"
  default     = "~/.ssh/id_rsa"
  type        = string
}

variable "host_ip" {
  description = "IP address of the local server"
  type        = string
}