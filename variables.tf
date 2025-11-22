variable "region" {
  type = string
}

variable "Public-Subnet-CIDR" {
  type = list(string)
}

variable "Private-Subnet-CIDR" {
  type = string

}
variable "Private-Subnet2-CIDR" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "availability_zone_2" {
  type = string
}
variable "db_username" {
  description = "Username for the database"
  type        = string
}
variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "public_key_path" {
  description = "Path to your public SSH key"
  type        = string
}
