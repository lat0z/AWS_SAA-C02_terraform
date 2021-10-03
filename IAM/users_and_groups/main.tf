terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.61"
        }
    }
}

provider "aws" {
    profile = "default" 
    region = "us-east-1"
}

resource "aws_iam_group" "admin" {
    name = "admin"
}

resource "aws_iam_group_policy_attachment" "attach"{
    group = aws_iam_group.admin.name
    policy_arn =  "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "admin" {
    name = "admin"
    tags = {
       department = "Engineering" 
    }
} 

resource "aws_iam_user_group_membership" "admin-group" {
    user = aws_iam_user.admin.name 
    groups = [
        aws_iam_group.admin.name
    ]
}

resource "aws_iam_user_login_profile" "admin-login" {
    user = aws_iam_user.admin.name
    pgp_key = "keybase:latoz"
    password_reset_required = true 
}