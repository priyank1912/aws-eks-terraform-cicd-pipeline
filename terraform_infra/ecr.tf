data "aws_iam_policy_document" "terraform_ecr_user" {
  statement {
    sid    = "AllowECRActions"
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "terraform_ecr_user_policy" {
  name        = "TerraformECRUserPolicy"
  description = "IAM user policy for ECR actions"
  policy      = data.aws_iam_policy_document.terraform_ecr_user.json
}

resource "aws_iam_user_policy_attachment" "attach_policy_to_priyank" {
  user       = var.user
  policy_arn = aws_iam_policy.terraform_ecr_user_policy.arn
}



resource "aws_ecr_repository" "frontend_repo" {
  name                 = "frontend_repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = {
    purpose = "priyank-personal-project"
  }
}

resource "aws_ecr_repository" "backend_repo" {
  name                 = "backend_repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = {
    purpose = "priyank-personal-project"
  }
}

