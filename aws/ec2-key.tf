# SSH key pair
data "external" "lpass" {
    query = {
        project = "Magento Placeholder"
    }
    program = ["bash", "${path.module}/scripts/lpass-scrape.sh"]
}

resource "aws_key_pair" "magento" {
    key_name = "magento-key"
    public_key = "${var.ssh_key}"
}
