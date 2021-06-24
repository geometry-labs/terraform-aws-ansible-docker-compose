module "ami" {
  source = "github.com/insight-infrastructure/terraform-aws-ami.git?ref=v0.1.0"
}

resource "aws_eip" "this" {
  count = var.create ? 1 : 0
  tags  = merge({ name = local.name }, var.tags)
}

resource "aws_eip_association" "this" {
  count       = var.create ? 1 : 0
  instance_id = join("", aws_instance.this.*.id)
  public_ip   = join("", aws_eip.this.*.public_ip)
}

resource "aws_key_pair" "this" {
  count      = var.public_key_path != "" && var.create ? 1 : 0
  public_key = file(var.public_key_path)
  tags       = merge({ name = local.name }, var.tags)
}

locals {
  vpc_security_group_ids = compact(concat([join("", aws_security_group.this.*.id)], var.additional_security_groups))
}

resource "aws_instance" "this" {
  count = var.create ? 1 : 0

  ami           = module.ami.ubuntu_1804_ami_id
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = local.vpc_security_group_ids
  key_name               = var.public_key_path == "" ? var.key_name : join("", aws_key_pair.this.*.key_name)

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }

  tags = merge({ Name = local.name }, var.tags)
}
