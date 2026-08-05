# Project 2 — Three-Tier Web Application
![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-7B42BC?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazonaws)
![License](https://img.shields.io/badge/License-MIT-green)

## Overview

This project provisions a production-grade three-tier web application architecture on AWS using Terraform. Public traffic is handled by an Application Load Balancer, routed to EC2 instances managed by an Auto Scaling Group, which connect to a private RDS MySQL database — all deployed across multiple availability zones for high availability.

This is the gold standard architecture question in cloud engineering interviews. Every resource is provisioned and managed entirely through Terraform — zero manual console configuration.

---

## Architecture

```
                        Internet
                            ↓
              Application Load Balancer
              (public subnets, AZ-a + AZ-b)
                       ↓        ↓
              EC2 Web Servers (Auto Scaling Group)
              (public subnet AZ-a + AZ-b)
                       ↓        ↓
                  RDS MySQL (Multi-AZ)
              (private subnet AZ-a + AZ-b)
```

![Architecture Diagram](screenshots/architecture.png)

---

## Resources Provisioned

| Layer | Resource | Details |
|---|---|---|
| Networking | VPC | 10.0.0.0/16 |
| Networking | Public Subnet A | 10.0.1.0/24 — us-east-1a |
| Networking | Public Subnet B | 10.0.2.0/24 — us-east-1b |
| Networking | Private Subnet A | 10.0.3.0/24 — us-east-1a |
| Networking | Private Subnet B | 10.0.4.0/24 — us-east-1b |
| Networking | Internet Gateway | Attached to VPC |
| Networking | Route Table | Public subnets → IGW |
| Security | ALB Security Group | Inbound 80/443 from internet |
| Security | EC2 Security Group | Inbound 80 from ALB only |
| Security | RDS Security Group | Inbound 3306 from EC2 only |
| Compute | Launch Template | Amazon Linux 2023, t3.micro |
| Compute | Auto Scaling Group | Min 1, Max 3, Desired 2 |
| Compute | Application Load Balancer | Internet facing |
| Compute | Target Group + Listener | HTTP port 80 |
| Database | RDS Subnet Group | Spans both private subnets |
| Database | RDS MySQL | db.t3.micro, Multi-AZ |

---

## Project Structure

```
tf-three-tier-web-app/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── database/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/
│   └── dev.tfvars
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── backend.tf
├── locals.tf
├── screenshots/
└── README.md
```

---

## Security Architecture

A key feature of this project is the layered security group design:

```
Internet → ALB Security Group (port 80/443 open to world)
ALB → EC2 Security Group (port 80 open to ALB only)
EC2 → RDS Security Group (port 3306 open to EC2 only)
```

The database is never directly accessible from the internet. Traffic must pass through the load balancer and web tier before reaching the database.

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- AWS CLI configured with appropriate credentials
- S3 bucket for remote state (reuse from Project 1)
- DynamoDB table for state locking (reuse from Project 1)

---

## Remote State Configuration

```hcl
terraform {
  backend "s3" {
    bucket       = "redni-terraform-backend"
    key          = "project2/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
```

---

## How to Deploy

**1. Clone the repository**
```bash
git clone https://github.com/Inderpreet2311/tf-three-tier-web-app.git
cd tf-three-tier-web-app
```

**2. Initialize Terraform**
```bash
terraform init
```

**3. Plan the deployment**
```bash
terraform plan -var-file="environments/dev.tfvars"
```

**4. Apply the configuration**
```bash
terraform apply -var-file="environments/dev.tfvars"
```

**5. Destroy resources when done**
```bash
terraform destroy -var-file="environments/dev.tfvars"
```

---

## Key Concepts Demonstrated

- **Three-Tier Architecture** — separation of presentation, logic, and data layers
- **Application Load Balancer** — distributes traffic across EC2 instances
- **Auto Scaling Group** — automatically adjusts EC2 capacity based on demand
- **Multi-AZ Deployment** — resources spread across two availability zones for high availability
- **Layered Security Groups** — each tier only accepts traffic from the tier above it
- **Private Database Subnet** — RDS is never exposed to the internet
- **Reusable Modules** — networking, compute, and database each in their own module
- **Remote State** — S3 backend with locking shared from Project 1

---

## Author

**Inder** — IT Operations transitioning to Cloud Engineering
[LinkedIn](https://linkedin.com/in/your-profile) | [GitHub](https://github.com/Inderpreet2311)

---

## License

MIT License — feel free to use this as a reference for your own projects.
