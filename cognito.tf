 resource "aws_cognito_user_pool" "data_tools" {
   name = "data tools access"
 }

resource "aws_cognito_user_pool_client" "data_tools" {
  name = "data-tools-client"
  user_pool_id = aws_cognito_user_pool.data_tools.id
  callback_urls = ["http://localhost:8080/oauth-authorized/AWS%20Cognito","http://localhost:8080/oauth-authorized/AWS%20Cognito/","http://localhost:8080/oauth-authorized/cognito/","http://localhost:8080/oauth-authorized/cognito", "http://localhost:8080/superset/welcome/"]
  prevent_user_existence_errors = "ENABLED"
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid"]
  supported_identity_providers         = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "data_tools" {
  domain       = "data-tools-domain"
  user_pool_id = aws_cognito_user_pool.data_tools.id
}

 
 resource "aws_cognito_user" "data_tools_admin" {
   user_pool_id = aws_cognito_user_pool.data_tools.id
   username     = "admin"
 }
