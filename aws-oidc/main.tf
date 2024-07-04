data "tls_certificate" "tfc_certificate" {
  url = "https://${var.tfe_hostname}"
}

# Creates an OIDC provider which is restricted to
resource "aws_iam_openid_connect_provider" "tfc_provider" {
  url             = data.tls_certificate.tfc_certificate.url
  client_id_list  = [var.tfc_aws_audience]
  thumbprint_list = [data.tls_certificate.tfc_certificate.certificates[0].sha1_fingerprint]
} 
############################################


module "project_oidc_aws" {
  source   = "github.com/hashi-demo-lab/tfc-dpaas-demo//terraform-aws-oidc-dynamic-creds"

  oidc_provider_arn            = aws_iam_openid_connect_provider.tfc_provider.arn
  oidc_provider_client_id_list = [var.tfc_aws_audience]
  tfc_organization_name        = "apj"
  cred_type                    = "project"
  tfc_project_name             = "Default Project"
  tfc_project_id               = var.tfe_project_id

}