# S3 Bucket
resource "aws_s3_bucket" "magento" {
    bucket = "${var.s3-bucket}"
    tags {
        Name = "Magento S3 Bucket"
        group = "mage-s3"
    }
}
