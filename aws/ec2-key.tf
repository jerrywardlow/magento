# SSH key pair
resource "aws_key_pair" "magento" {
    key_name = "magento-key"
    public_key = "${file("ssh/magento-key.pub")}"
}
