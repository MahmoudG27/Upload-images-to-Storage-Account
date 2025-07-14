data "template_file" "vm_script" {
  template = file("${path.module}/script.sh.tpl")

  vars = {
    mysql_host     = var.db_host
    mysql_user     = var.db_user
    mysql_password = var.db_user_password
  }
}