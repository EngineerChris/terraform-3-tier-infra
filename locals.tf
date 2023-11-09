locals {
  project_tags = {
    contact = "deveops@company.com"
    application = "payments"
    project = "abcProject"
    environment = "${terraform.workspace}"
   # creationTime = timestamp()
    creationTime = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())

  }
}


