resource "aws_eip" "eip" {
  count    = var.eip == null ? 0 : 1
  domain   = var.eip.domain
  tags     = var.eip.tags
}