# Secret manager to store the RDS credentials 

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"

}

resource "aws_secretmanager_secret" "rds_credentials" {
  name        = "rds-credentials"
  description = "RDS credentials"
}

# set the values of the secrets in the secret manager 
resource "aws_secretsmanager_secret_version" "rds_credentails_version" {
  secret_id = aws_secretmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.password.result
  })

}