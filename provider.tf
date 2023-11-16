terraform {
  #############################################################
  ## When first creating this in a new account, comment out the
  ## following "backend" block for the first run.  Once stacked
  ## re-run init after un-commenting the backend block.
  #############################################################
  backend "s3" {
    bucket         = "supersetdemo-terraform-535710392721"  #REPLACE WITH ACCOUNT_ID.  Vars NOT allowed here.
    key            = "state/demo/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
