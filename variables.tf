variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"  # Change if deploying to a different region
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t2.micro"    # Adjust based on your performance needs
}

variable "key_name" {
  description = "The name of the SSH key pair to use for access"
  type        = string
  default     = "try-key"       # Make sure this key pair exists in your AWS account
}

variable "ssh_private_key" {
  description = "The private key for SSH access"
  type        = string
  default     = "~/.ssh/id_rsa"  # Update if using a different key
}

variable "ssh_public_key" {
  description = "The public key for SSH access"
  type        = string
  default     = "~/.ssh/id_rsa.pub"  # Update if using a different key
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instance"
  type        = string
  default     = "ami-0fff1b9a61dec8a5f"  # Ensure this AMI ID is valid in your region
}
