resource "aws_security_group" "intro-aws-batch" {
  name = "intro-aws-batch"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "intro-aws-batch" {

  from_port = 0
  protocol = ""
  security_group_id = aws_security_group.intro-aws-batch.id
  to_port = 0
  type = ""
}