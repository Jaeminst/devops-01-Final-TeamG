variable "region_number" {
  # Arbitrary mapping of region name to number to use in
  # a VPC's CIDR prefix.
  default = {
    us-east-1      = 1
    us-west-1      = 2
    us-west-2      = 3
    eu-central-1   = 4
    ap-northeast-2 = 5
  }
}

variable "multi_az" {
  description = "RDS: Setup of multi az? (true/false)"
  type = bool
}

variable "db_use_data" {
  description = "Database start used table name"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "github_organization" {
  description = "GitHub Organization Name"
  default = "devops-team-rm-rf"
}

variable "github_repository" {
  description = "GitHub Repository Name"
  default = "reservation-api-server"
}

variable "github_repository_elk" {
  description = "GitHub Repository Name"
  default = "docker-elk"
}


variable "service_name" {
  description = "Service App Name"
  default = "reservation-server"
}

variable "server_port" {
  description = "Port from EC2 on App port"
  type = number
}

variable "rds_port" {
  description = "Port from RDS"
  type = number
}

variable "elk_version" {
  description = "Elastic Version"
  type = string
}
variable "elastic_password" {
  description = "Elastic Password"
  type = string
}
variable "logstash_password" {
  description = "Logstash Password"
  type = string
}
variable "kibana_password" {
  description = "Kibana Password"
  type = string
}