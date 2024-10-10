resource "random_pet" "this" {
  prefix = var.prefix
  length = 10

  keepers = {
    timestamp = timestamp()
  }
}

resource "time_sleep" "wait" {
  create_duration = "1m"

  triggers = {
    # This will change whenever the pet changes, causing the sleep to occur
    pet_id = random_pet.this.id
  }
}

# resource "null_resource" "this" {
#   count      = var.instances
#   depends_on = [time_sleep.wait]
#
#   triggers = {
#     pet = random_pet.this.id
#   }
# }

# This is to add some memory load - 2 instances of AWS to different regions
# and datasource output to increase returned run payload.
# We don't actually want to provision resources as its a mess to clean up broken runs.

# # query for eks clusters
# data "aws_eks_clusters" "a" {
# }
#
# # Query AWS Caller Identity reion a
# data "aws_caller_identity" "a" {
# }

# Query AWS Caller Identity region b
/* data "aws_caller_identity" "b" {
 # provider = aws.b
}
*/