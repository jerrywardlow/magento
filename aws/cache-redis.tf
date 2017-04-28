resource "aws_elasticache_cluster" "redis" {
    cluster_id = "${var.elasticache-cluster-id}"
    engine = "redis"
    node_type = "${var.elasticache-node-type}"
    port = "${var.elasticache-port}"
    num_cache_nodes = 1 # NOTE: This is the required number for Redis
    parameter_group_name = "${aws_elasticache_parameter_group.mage.name}"
    security_group_ids = ["${aws_security_group.redis.id}"]
    subnet_group_name = "${aws_elasticache_subnet_group.default.name}"

    tags {
        group = "mage-redis"
    }
}

# ElastiCache subnet group
resource "aws_elasticache_subnet_group" "default" {
    name = "mage-redis-subnet-group"
    description = "Subnet group for ElastiCache/Redis"
    subnet_ids = ["${aws_subnet.private.*.id}"]
}

# ElastiCache parameter group
resource "aws_elasticache_parameter_group" "mage" {
    name = "mage-redis"
    family = "redis3.2"
}
