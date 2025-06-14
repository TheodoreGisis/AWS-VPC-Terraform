vpc_cidr = "10.0.0.0/16"
vpc_name = "my-vpc"

availability_zones = [
  "eu-central-1a",
  "eu-central-1b",
  "eu-central-1c"
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24"
]

private_subnets = [
  "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24",
  "10.0.104.0/24", "10.0.105.0/24", "10.0.106.0/24"
]
