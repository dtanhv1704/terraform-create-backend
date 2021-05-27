output "backend-bucket" {
  value = aws_s3_bucket.terraform_state.id
}

output "db_locks" {
  value = aws_dynamodb_table.terraform_locks.id
}