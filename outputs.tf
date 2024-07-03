output "name" {
  value = random_pet.this.id
}

output "ids" {
  value = [for n in null_resource.this : n.id]
}
