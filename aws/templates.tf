# User-data template
data "template_file" "user_data" {
    template = "${file("templates/user_data.tpl")}"

    vars {
        rds_endpoint = "${aws_db_instance.mysql.address}"
        s3_bucket = "${aws_s3_bucket.magento.id}"
        redis_endpoint = "${aws_elasticache_cluster.redis.cache_nodes.0.address}"
    }
}
