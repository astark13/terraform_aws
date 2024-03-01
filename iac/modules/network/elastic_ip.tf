resource "aws_eip" "webserver_eip" {
  count    = var.eip == null ? 0 : 1
  domain   = var.eip.domain
  tags     = var.eip.tags
}