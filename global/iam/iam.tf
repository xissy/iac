
resource "aws_iam_user" "taeho" {
  name = "taeho"
  path = "/"
}

resource "aws_iam_policy_attachment" "AdministratorAccess-policy-attachment" {
  name       = "AdministratorAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  groups = [
    "Administrators",
  ]
  users = [
    aws_iam_user.taeho.name,
  ]
  roles = []
}
