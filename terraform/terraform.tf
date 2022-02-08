/*
we will define a provider and a default region here. It's more dinamyc if we use environmet variables
but having the region expelicitly defined is more clear for the reader
*/

provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "local" {
    path = "tf_state/terraform.tfstate"
  }
}
