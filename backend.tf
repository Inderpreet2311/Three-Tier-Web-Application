terraform {
    backend "s3" {
        bucket = "redni-terraform-backend"
        key = "project2/terraform.tfstate"
        region = "us-east-1"
        use_lockfile = true
        encrypt = true

    }
}