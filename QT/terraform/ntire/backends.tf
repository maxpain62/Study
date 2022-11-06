terraform {
  backend "s3" {
        bucket = "backend-06112022"
        key = "ntierdeploydev"
        region = "ap-south-1"
        dynamodb_table = "thisisforteraform"
  }
}