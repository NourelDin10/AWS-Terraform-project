# AWS Infrastructure with Terraform

Terraform script to provision AWS infrastructure for an e-commerce application with Node.js frontend, Laravel backend, and MySQL database.

## Task Requirements

- **Backend Machine**: 1 core, 1 GB RAM, 8 GB disk, public IP, Ubuntu 22.04
- **Frontend Machine**: 1 core, 1 GB RAM, 8 GB disk, public IP, Ubuntu 22.04
- **MySQL RDS**: Community version 8, lowest plan, no internet exposure

## Prerequisites

1. **Terraform** (>= 1.0)
   ```bash
   terraform version
   ```

2. **AWS CLI** configured with credentials
   ```bash
   aws configure
   ```

3. **SSH Key Pair**
   - Generate if needed: `ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa`
   - Public key should be at `~/.ssh/id_rsa.pub` (or update path in `variables.tf`)

## Project Structure

```
.
├── provider.tf         # Terraform provider configuration
├── variables.tf        # Variable definitions
├── vpc.tf              # VPC, subnets, internet gateway, routing
├── Sec-group.tf        # Security group definitions
├── ec2.tf              # EC2 instances and key pair
├── rds.tf              # RDS MySQL database
├── output.tf           # Output values
└── README.md           # This file
```

## Configuration

Edit `variables.tf` or create `terraform.tfvars`:

```hcl
region = "us-east-1"
availability_zone   = "us-east-1a"
availability_zone_2  = "us-east-1b"

Public-Subnet-CIDR   = ["10.0.1.0/24", "10.0.2.0/24"]
Private-Subnet-CIDR  = "10.0.3.0/24"
Private-Subnet2-CIDR = "10.0.4.0/24"

db_username = "admin"
db_password = "YourSecurePassword123"  # Must not contain /, @, ", or spaces

public_key_path = "~/.ssh/id_rsa.pub"
```

## Usage

### 1. Initialize Terraform

```bash
terraform init
terraform plan
terraform apply
```

### 2. Review Plan

```bash
terraform plan
```

## Outputs

```bash
terraform output
```

- `frontend_public_ip` - Frontend EC2 public IP
- `backend_public_ip` - Backend EC2 public IP
- `rds_endpoint` - RDS MySQL endpoint

## Access

**SSH to EC2:**
```bash
ssh -i ~/.ssh/id_rsa ubuntu@<public_ip>
```

**Connect to RDS:**
```bash
mysql -h <rds_endpoint> -u admin -p
```

## Cleanup

```bash
terraform destroy
```
