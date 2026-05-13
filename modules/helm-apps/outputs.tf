output "helm_release_names" {
  description = "Application Helm release names."
  value       = { for name, release in helm_release.apps : name => release.name }
}
