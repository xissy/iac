# iac
> Infra-as-Code by Terraform

## Directory structure
Inspired by https://rampart81.github.io/post/terraform-directory-structure/

### Sample
```
infrastructure
├── global
│   ├── cloudfront
│   ├── route53
│   │   ├── hosted_zones
│   │   └── records
│   ├── iam
│   └── s3
├── management
│   ├── services
│   │   ├── ci
│   │   ├── key_management
│   │   ├── monitoring
│   │   └── vpn
├── production
│   ├── database
│   │   └── aurora
│   │   └── redis
│   ├── services
│   │   ├── backend
│   │   └── frontend
│   │   └── queue
│   │       └── msk
│   │       └── sqs
│   ├── vpc
│   └── eks
├── staging
│   ├── database
│   │   └── mysql
│   │   └── redis
│   ├── services
│   │   ├── backend
│   │   └── frontend
│   ├── vpc
│   └── eks
└─── development
    ├── database
    │   └── mysql
    │   └── redis
    ├── services
    │   ├── backend
    │   └── frontend
    ├── vpc
    └── eks
```

## Terraform State Files
All `tfstate` files are on `taeho-io-iac-terraform-state` S3 bucket as the
same directory structure.
