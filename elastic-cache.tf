resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "robot-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = "6.2"
  port                 = 6379
  security_group_ids   = [aws_security_group.allow_redis.id]
}

# Creates Parameter group
resource "aws_elasticache_parameter_group" "default" {
  name                 = "robot-${var.ENV}-redis-pg"
  family               = "redis6.2"
}

# Creates Subnet Group
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name                 = "robot-${var.ENV}-redis-subet-group"
  subnet_ids           = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}
