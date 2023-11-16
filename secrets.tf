resource "aws_secretsmanager_secret" "docker_credentials" {
  name = "docker/credentials"
}

resource "aws_secretsmanager_secret_version" "docker_credentials" {
  secret_id     = aws_secretsmanager_secret.docker_credentials.id
  secret_string = "example-string-to-protect"
}


resource "aws_secretsmanager_secret" "github_credentials" {
  name = "github/credentials"
}

resource "aws_secretsmanager_secret_version" "github_credentials" {
  secret_id     = aws_secretsmanager_secret.github_credentials.id
  secret_string = "example-string-to-protect"
}


resource "aws_secretsmanager_secret" "oath_credentials" {
  name = "cognito/credentials"
}

resource "aws_secretsmanager_secret_version" "oauth_credentials" {
  secret_id     = aws_secretsmanager_secret.oath_credentials.id
  secret_string = jsonencode({
    client:aws_cognito_user_pool_client.data_tools.id, 
    secret:aws_cognito_user_pool_client.data_tools.client_secret,
    url:"https://data-tools-domain.auth.us-west-2.amazoncognito.com"
    })
}
