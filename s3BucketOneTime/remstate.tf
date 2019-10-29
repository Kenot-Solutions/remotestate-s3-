
resource "aws_s3_bucket" "terraform-s3-bucket" {
    bucket = "terraform-s3-kenot-state-files"
    region = "us-west-1"

    versioning {
        enabled = false
    }
    lifecycle {
        prevent_destroy = false
    }
    tags = {
        Name = "S3 Remote store"
    }

     # "Sid": "PublicReadForGetBucketObjects",
      policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::350889164528:user/terraformusertolgay"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::terraform-s3-kenot-state-files"
        }
    ]
}
EOF
}


resource "aws_dynamodb_table" "terraform-state-lock" {
 name = "terraform-state-lock"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }
  tags ={
    Name = "Terraform State Lock Table"
  }
}