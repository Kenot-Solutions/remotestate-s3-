

 
# Resource to create Dynamodb table for locking the state file
/* resource "aws_dynamodb_table" "terraform-state-lock" {
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
} */

 terraform {
  backend "s3" {
    encrypt = true                             //encrypts data
    bucket = "terraform-s3-kenot-state-files"      //name of s3 bucket
    region = "us-west-1"                       //region
    key = "remote/terraform.tfstate "           //name of tfstate file
    dynamodb_table = "terraform-state-lock"      //dynamoDB table for state locking
  }
}
