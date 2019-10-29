# remotestate-s3

Terraform Remote State to S3

*** Please check the terraform.tfvars and add your keys to the file

-- First
 Create S3 Bucket and DynamoDB 

cd s3BucketOneTime
*** check the note 

terraform init 
terraform apply


-- Second

cd ..

*** check the note

terraform init 
terraform apply


now you can check the remote state file from the bucket. 


do not forget to destory the created VPC and its components


terraform destory
