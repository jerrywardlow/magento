# User-data template
data "template_file" "user_data" {
    template = "${file("templates/user_data.tpl")}"

    vars {
        pass = "pass"
    }
}
