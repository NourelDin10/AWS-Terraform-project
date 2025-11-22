
resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "mysql-subnet-group"
  subnet_ids = [
    aws_subnet.database-private.id,
    aws_subnet.database-private2.id,
  ]
}

resource "aws_db_instance" "mysql" {
  identifier             = "mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
}
