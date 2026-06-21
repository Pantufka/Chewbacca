aws_region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

app_subnets = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

db_subnets = [
  "10.0.21.0/24",
  "10.0.22.0/24"
]

instance_type = "t2.micro"

db_instance_class = "db.t3.micro"

db_username = "admin"

db_password = "CambiarPorUnaPasswordSegura123!"