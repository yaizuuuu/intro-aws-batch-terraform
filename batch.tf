resource "aws_batch_compute_environment" "intro-aws-batch" {
  compute_environment_name = "intro-aws-batch"

  compute_resources {
    instance_role = aws_iam_instance_profile.ecs_instance_role.arn

    instance_type = [
      "c5.large",
      "m5.large",
      "t3.large",
      "c4.large",
      "m4.large",
      "t2.large",
    ]

    max_vcpus = 2
    min_vcpus = 0

    security_group_ids = [
      aws_security_group.default.id,
    ]

    subnets = [
      aws_subnet.pri-a.id,
      aws_subnet.pri-c.id,
    ]

    type = "EC2"

    image_id = ""
  }

  service_role = aws_iam_role.aws_batch_service_role.arn
  type         = "MANAGED"
  depends_on   = [aws_iam_role_policy_attachment.aws_batch_service_role]
}
