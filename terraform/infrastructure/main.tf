provider "aws" {
  region  = "${var.region}"
}

resource "aws_key_pair" "ops" {
    key_name = "ops"
    public_key = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDax5WCB17anGNhTOHJDIjBdzxri5Q/O9fSW0O6Izut
KG8oxgntpv11F15mbZm3pd+dVEo402thMXHv1u1LWeB6zUNoRYkB4PsTZqx8dmnMuR1aW4tuYMH3pIyR
7R0DmUgK4euFe/5MehP3evHErrHAknIvtqG96KSvX7/lOvEFe/LillSH7CtsCH1uCoK/3c9c8btoMKXq
hlU99o5M07rTVvcRvzsEGYHmSmBxjbCaJRsRWbFYuPLpzV7ADV0eoC0s+cE1sN45iWHDlEsxa52yjIhm
4qSmtUPbWrp+hU9TCJ6cyrVHEjIn02Ab1mcuYSvMNV/Oxv6lS1M9mh5kWA3h
EOF
}
