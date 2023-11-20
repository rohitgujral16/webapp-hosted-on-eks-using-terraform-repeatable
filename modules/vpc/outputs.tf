output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_cidr" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "private_subnet_id" {
  value = module.vpc.private_subnets
}

output "public_subnet_id" {
  value = module.vpc.public_subnets
}
