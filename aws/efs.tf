# Elastic File System
resource "aws_efs_file_system" "mage-efs" {
    creation_token = "mage-efs-test-id"
    tags {
        Name = "mage-efs"
        group = "mage-efs"
    }
}

resource "aws_efs_mount_target" "efs-mount" {
    count = 3
    file_system_id = "${aws_efs_file_system.mage-efs.id}"
    subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
    security_groups = [
        "${aws_security_group.efs.id}"
    ]
}
