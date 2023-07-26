resource "aws_iam_role" "iam-policy" {
  name = "Cloudwatch-full-access"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )

  tags = {
    Name = "Cloudwatch-full-access"
  }
}

resource "aws_iam_role_policy" "role-policy" {
  name = "CloudWatchFullAccess"
  role = aws_iam_role.iam-policy.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "autoscaling:Describe*",
            "cloudwatch:*",
            "logs:*",
            "sns:*",
            "iam:GetPolicy",
            "iam:GetPolicyVersion",
            "iam:GetRole",
            "oam:ListSinks"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : "iam:CreateServiceLinkedRole",
          "Resource" : "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
          "Condition" : {
            "StringLike" : {
              "iam:AWSServiceName" : "events.amazonaws.com"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "oam:ListAttachedLinks"
          ],
          "Resource" : "arn:aws:oam:*:*:sink/*"
        }
      ]
    }
  )
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "CloudWatchFullAccess"
  role = aws_iam_role.iam-policy.name
}

