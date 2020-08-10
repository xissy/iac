
locals {
  zone_ids = {
    taeho_io = data.terraform_remote_state.hosted_zone.outputs.taeho_io_zone_id
  }
}
