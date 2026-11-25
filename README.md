# Security Groups Linear

A Terraform module that creates two AWS security groups in an existing VPC and
allows TCP traffic between them over a configurable port range. It adds
reciprocal ingress and egress rules that reference the other security group.

## Requirements

| Name | Version |
| --- | --- |
| Terraform | `~> 1.16` |
| AWS provider | `~> 6.0` |

The AWS provider must be configured for the account and region where the
security groups will be created.

## Usage

```hcl
module "security_groups_linear" {
  # Update this path to the location of the module in your configuration.
  source = "./modules/security-groups-linear"

  security_group_names = [
    "public",
    "private",
  ]
  vpc_id     = "vpc-0123456789abcdef0"
  from_port  = "443"
  to_port    = "443"
}
```

This example permits TCP traffic on port 443 in both directions between the
two security groups. Update the VPC ID, names, and port range for your
configuration.

## Inputs

| Name | Type | Description |
| --- | --- | --- |
| `security_group_names` | `list(string)` | Names for the two security groups to create. Exactly two names are required. |
| `vpc_id` | `string` | ID of the VPC in which to create the security groups. |
| `from_port` | `string` | First port in the allowed TCP port range. |
| `to_port` | `string` | Last port in the allowed TCP port range. |

## Outputs

This module does not currently define outputs.

## Limitations

- Exactly two security groups are supported.
- Rules are TCP only and use the same port range for ingress and egress.
- Rules reference the other security group; this module does not add
  CIDR-based rules.
