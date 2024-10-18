
resource "aws_iam_user" "u1" {
  name = "LAKSHA"
}


resource "aws_iam_user" "u2" {
  name = "Dhananjay-Mane"

}


resource "aws_iam_user" "u3" {
  name = "Tatya-Vinchu"

}


resource "aws_iam_user" "u4" {
  name = "Mahesh"
}

resource "aws_iam_group" "g1" {
  name = "Zapatlela"

}

resource "aws_iam_group_membership" "add" {
    name = "grpadd"

    users = [
        aws_iam_user.u1.name,
        aws_iam_user.u2.name,
        aws_iam_user.u3.name,
        aws_iam_user.u4.name
    ]
    group = aws_iam_group.g1.name
}
