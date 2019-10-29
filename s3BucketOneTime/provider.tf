provider "aws" {
  version = "~> 2.0"
  region  = "${var.AWS_REGION}"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  
  #https://skeltonthatcher.com/blog/auto-generated-infrastructure-graphs-terraform-plans/

}