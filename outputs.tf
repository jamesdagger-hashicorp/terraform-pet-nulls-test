output "name" {
  value = random_pet.this.id
}

output "ids" {
  value = [for n in null_resource.this : n.id]
}

output  "gcp_project_number" {
  value = data.google_project.project.number
}