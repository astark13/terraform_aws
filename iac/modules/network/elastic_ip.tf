data "aws_instance" "webserver" {
  count = var.eip == null ? 0 : 1
  instance_id = var.eip.instance_id
}

resource "aws_eip" "webserver_eip" {
  count    = var.eip == null ? 0 : 1
  domain   = "vpc"
  instance = data.aws_instance.webserver[0].id
  tags     = var.tags
}