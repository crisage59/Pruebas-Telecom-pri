resource "aws_cognito_user_pool_client" "client" {
  name                = "${var.tags.Site}-pool-client"
  user_pool_id        = var.user_pool_id
  generate_secret     = true
  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]

  # Habilitar los flujos de OAuth (Authorization code grant)
  allowed_oauth_flows = ["code"]  # Solo Authorization Code Grant
  allowed_oauth_scopes = ["openid"]  # Sólo el alcance openid

  supported_identity_providers = ["COGNITO"]

  allowed_oauth_flows_user_pool_client = true
  token_validity_units {

    refresh_token = "days"
    access_token  = "minutes"
    id_token      = "minutes"
  }
  callback_urls          = ["https://${var.tags.Site}.cba.gov.ar/oauth2/idpresponse"]
  logout_urls          = ["https://${var.tags.Site}.cba.gov.ar"]
  access_token_validity  = 60
  id_token_validity      = 60
  refresh_token_validity = 1
}


