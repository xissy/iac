

resource "aws_route53_record" "taeho-io-NS" {
  zone_id = local.zone_ids.taeho_io
  name    = "taeho.io"
  type    = "NS"
  records = [
    "ns-538.awsdns-03.net.",
    "ns-1590.awsdns-06.co.uk.",
    "ns-366.awsdns-45.com.",
    "ns-1241.awsdns-27.org.",
  ]
  ttl = "172800"
}

resource "aws_route53_record" "taeho-io-SOA" {
  zone_id = local.zone_ids.taeho_io
  name    = "taeho.io"
  type    = "SOA"
  records = [
    "ns-538.awsdns-03.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
  ttl = "900"
}

resource "aws_route53_record" "taeho-io-MX" {
  zone_id = local.zone_ids.taeho_io
  name    = "taeho.io"
  type    = "MX"
  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
  ]
  ttl = "3600"
}

resource "aws_route53_record" "api-taeho-io-A" {
  zone_id = local.zone_ids.taeho_io
  name    = "api.taeho.io"
  type    = "A"
  alias {
    name                   = "d-hlws06mzr6.execute-api.ap-northeast-2.amazonaws.com"
    zone_id                = "Z20JF4UZKIW1U8"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ssh-taeho-io-A" {
  zone_id = local.zone_ids.taeho_io
  name    = "ssh.taeho.io"
  type    = "A"
  records = [
    data.terraform_remote_state.ec2.outputs.bastion_public_ip
  ]
  ttl = "3600"
}
