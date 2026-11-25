resource "aws_security_group" "this" {
  for_each = toset(var.security_group_names)
  name = each.value
  vpc_id = module.vpc.vpc_id
}


resource "aws_vpc_security_group_egress_rule" "private_public_out" {
for_each = aws_security_group.this

security_group_id = each.value.id
to_port = var.to_port
from_port = var.from_port
ip_protocol = "tcp"
referenced_security_group_id = one([
    for i, v in aws_security_group.this : tostring(v.id)  
    if i != each.key
])

depends_on = [ aws_security_group.this ]
}

resource "aws_vpc_security_group_ingress_rule" "private_public_out" {
for_each = aws_security_group.this

security_group_id = each.value.id
to_port = var.to_port
from_port = var.from_port
ip_protocol = "tcp"
referenced_security_group_id = one([
    for i, v in aws_security_group.this : tostring(v.id)  
    if i != each.key
])

depends_on = [ aws_security_group.this ]
}
