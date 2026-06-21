resource "aws_db_subnet_group" "main" {
  name = "Chewbacca-DB-SubnetGroup"
  subnet_ids = var.db_subnet_ids
  description = "Subnet Group para la DB en subredes privadas"
  tags = {
    Name = "Chewbacca-DB-SubnetGroup"
  }
}

resource "aws_db_instance" "main" {
  identifier = "Chewbacca-DB"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = var.db_instance_class
  allocated_storage = 20
  storage_type = "gp2"
  username = var.db_username
  password = var.db_password
  db_name = "Chewbacca"
  port = 3306
  multi_az = true
  publicly_accessible = false
  skip_final_snapshot = true
  backup_retention_period = 7
  backup_window = "03:00-04:00"
  vpc_security_group_ids = [
    var.db_sg_id
  ]
  db_subnet_group_name = aws_db_subnet_group.main.name
  tags = {
    Name = "Chewbacca-RDS"
  }
}