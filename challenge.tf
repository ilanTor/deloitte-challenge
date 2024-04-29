# Define provider
provider "aws" {
  region = my-aws-region
}

# Create KMS key, S3 Bucket, enable Server Side encryption and implement security control PR.DS-1 (Data-at-rest is protected)
resource "aws_kms_key" "mykmskey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "mykmskey" {
  name          = "alias/my-alias-namw"
  target_key_id = aws_kms_key.mykmskey.key_id
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykmskey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Create EC2 instance and implement security control PR.AC-4 (Access permissions and authorizations are managed)
resource "aws_instance" "example_instance" {
  ami           = "my-ami-id" # Example AMI, pre-configured
  instance_type = "t2.micro"

  tags = {
    Name = "my-ec2-instane-name"
  }

  # Security Group
  security_groups = [aws_security_group.my_instance_sg.name]
}

# Define security group for EC2 instance
resource "aws_security_group" "my_instance_sg" {
  name        = "my_instance_sg"
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ONLY SSH access from anywhere
  }
}

# Implement security control PR.AC-4 for EC2 instance
resource "aws_security_group_rule" "instance_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_instance_sg.id
}

# Detect Function: 
# Although not implemented in this script, the Detect function can be achieved 
# through the use of AWS CloudTrail, Amazon GuardDuty, and AWS Config.

# Respond Function: 
# Organizations can implement automated response mechanisms using AWS Lambda 
# functions triggered by CloudWatch Events to respond to security incidents in real-time.

# Recover Function: 
# The Recover function involves restoring services and data after a security incident. 
# This can be accomplished by leveraging AWS Backup for data recovery and restoring 
# EC2 instances from snapshots or backups stored in Amazon S3.
